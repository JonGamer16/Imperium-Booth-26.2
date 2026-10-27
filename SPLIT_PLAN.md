# Three-pack split — plan

Status: **planning** (2026-10-27). Nothing has been moved yet. This file is the inventory and the
coupling map to work from. Recent changes are in [CHANGELOG.md](CHANGELOG.md).

## Goal

Make as much of Imperium as possible playable in a normal survival world, and add craftable weapons
and items, without breaking the kit-PvP game. Split the one pack into three:

| Pack | Working name | Contents | Needs |
|---|---|---|---|
| **Core** | `imperium` | Enchantments, motion module, cooldown engine, shared triggers, constants | — |
| **Kit PvP** | `imperium_kitpvp` | The 7 kits, booth, arena / FFA, gold, training dummy, kit select | Core |
| **Survival** | `imperium_smp` | Recipes, loot-table injections, survival-side ability gating, new craftables | Core |

Core must load and run cleanly **on its own**, so a survival world can run core + survival with no
booth code at all.

## Decisions to make first

1. **Namespace.** *Recommended: keep `imperium:` in all three packs, with disjoint paths.* Data
   packs merge a namespace across packs, so moving a file to another pack changes **no IDs** and
   rewrites no references. The split is just file moves plus the hooks below. The alternative,
   renaming to `imperium_kitpvp:` etc., touches hundreds of references for no functional gain. It
   can still happen later, one pack at a time.
2. **Where the cooldown engine lives.** *Recommended: core.* The slot engine
   (`update_cooldowns`, `set_cd`, the `cooldown_*` triggers, `rearm_triggers`) knows nothing about
   specific kits. Only `kit_dispatch` does, and that becomes a hook. Survival can then reuse the
   same charge-by-damage model for craftable ability items.
3. **How abilities are gated in survival.** Today `imperium:ability_zone` means "has `im.kitted`".
   Survival players never get a kit tag, so every gated advancement (the cooldown engine, kinetic
   charge, venom, reversal, ...) is dead for them. The options:
   - (a) gate on the **held item** (e.g. `custom_data` or the enchantment itself),
   - (b) make survival grant its own tag,
   - (c) make `ability_zone` an `any_of` that each pack adds a term to. Predicates don't merge
     across packs, so (c) means core owns the file and lists every term.

   This decision shapes the whole survival pack.

## Inventory — where each piece goes

### Core (`imperium`)

| Path | Notes |
|---|---|
| `function/motion/*` | Launch module (replaced summit-dp-core `player_motion`). |
| `function/update_cooldowns`, `abilities/set_cd` | Slot engine. |
| `function/internal/cooldown_*`, `rod_broke`, `arrow_recount`, `record_attacker`, `damage_light` | Shared triggers. `record_attacker` feeds the kill feed, so check where it belongs. |
| `function/util/rearm_triggers`, `util/debug`, `util/delete_objectives` | `rearm_triggers` must list only **core** advancements, and each pack needs its own (see hooks). |
| `function/main/constants`, the core parts of `main/enchantments`, `main/init_stats` | |
| `function/test/*` (except the probes) | Debug toggles. |
| `function/tick`, `loop_tick`, `loop_5t`, `loop_1s`, `loop_enchantments` | Keep the **driver** in core, and move every kit/booth line out behind hooks. |
| `function/enchantments/{backstab*, high_jump*, straight_flight, volley_*}` | Self-contained. |
| `enchantment/{backstab, crits, crossbow_power, crossbow_punch, high_jump, mace_smash, marked, motion_impulse, single_use, straight_flight, volley}` | Self-contained effects. |
| `damage_type/{light, volley_reset}`, `tags/damage_type/*`, `tags/enchantment/*` | |
| `predicate/{ability_zone, on_ground, floating, sneaking, input_sneak, player_input/*, motion/*}` | |
| `minecraft/tags/function/{tick, load}.json` | Function tags merge, so each pack can add its own entries. |

### Kit PvP (`imperium_kitpvp`)

| Path | Notes |
|---|---|
| `function/kits/*` (140 files) | All 7 kits, including `kits/*/booth/*`. |
| `function/kit_dispatch` | Becomes a hook target (see below). |
| `function/booth/*`, `arena/*`, `ffa/*` | Booth, kit stands, dummy, gold, respawn, kill feed. |
| `function/util/{clear_kit, giveheals, giveloot, copy_gear, reset_player}` | |
| `function/main/{ability_cooldowns, ability_parameters, game_triggers, init_cooldowns}` | Per-kit tuning. |
| `function/abilities/{leap, leap_refund}` | Gated on `im.kit_livvy` / `im.kit_meowdy` and `im_cdUsesA`. |
| `function/enchantments/{reversal*, offhand_*, lifesteal*, aim_*}` | Kit-gated (Levent, Smokey, Livvy, Rastus/Levent tracker). |
| `enchantment/{reversal, offhand_attack, lifesteal, focus_attack, charge_attack, golem_throw, barrier, grappling, reeling, leap}` | Either call kit functions or are tooltip markers for kit trackers. |
| `advancement/booth/*`, `levent_*`, `rastus_*`, `use_*`, `raise_shield`, `attack_player`, `combat/venom_bite`, `combat/hurt_by_player` | |
| `loot_table/<kit>/*`, `item_modifier/*`, `dialog/kitselect`, `structure/imperium_arena`, `sync_setting/kit` | |
| `damage_type/{bomb, venom}`, `predicate/{safe_zone, at_spawn, has_bad_omen, has_venom, booth/*}` | |
| `minecraft/tags/entity_type/*` | Dummy and fencer helpers. |

### Survival (`imperium_smp`)

| Path | Notes |
|---|---|
| `recipe/*` | The 3 existing recipes (diamond dagger / glaive / rapier) predate 26.2 and need fixing. The glaive's `item_name` is a JSON string. |
| `loot_table/smp_weapons/` | Already exists, but empty (created 2026-10-27). |
| *(new)* | Craftable weapons and items, loot injections, survival ability gating (decision 3). |

## Coupling to cut (core → kit PvP)

Core must never call into kit PvP, or core alone would log `Unknown function` errors. Each call
below becomes a **function tag hook**: core owns an empty `#imperium:hooks/<name>` and calls it;
kit PvP adds its functions to the tag.

| Where | Today it calls | Hook |
|---|---|---|
| `update_cooldowns` → `kit_dispatch` | `kits/<kit>/abilities` ×7 | `#imperium:hooks/cooldown_ready` |
| `loop_tick` | `kits/{smokey,mummy,livvy,rastus,levent}/*`, `booth/dummy/dmg_tick`, `arena/on_death` | `#imperium:hooks/tick` |
| `loop_1s` | `arena/{calc_gold, gold_kill_bonus, respawn}`, the `im.no_regen` saturation | `#imperium:hooks/second` |
| `tick` | `booth/{enter,exit}_booth` (and the idle gate reads `imperium:safe_zone`) | `#imperium:hooks/tick`, with the gate reworked |
| `loop_enchantments` | Livvy lifesteal lines (`im.kit_livvy`) | move the lines to kit PvP |
| `internal/reset_drought` | `kits/rastus/combo_hit` | `#imperium:hooks/hit_landed` |
| `internal/cooldown_dealt_apply` | `arena/gold_dmg_bonus` | `#imperium:hooks/hit_human` |
| `internal/venom_bite` | `im.kit_livvy` gate | move the file to kit PvP |
| `main` | kit sections, the dummy, the `im.equip_cd` / `im.kitted` backfill | each pack runs its own load function |
| `util/rearm_triggers` | lists kit PvP advancements | split: one per pack, both run on load |

**Watch out:**
- A function tag that lists a function which doesn't exist fails to load as a whole. Keep each
  pack's tag entries pointing only at that pack's own files. Where an entry may legitimately be
  missing, write it as `{"id": "imperium:...", "required": false}`.
- **Load order:** core's load must create the shared objectives before the other packs' loads use
  them. Load tags across packs run in pack order, so either list core first, or have each pack's
  load call `function imperium:main/constants` (it's idempotent).

## Survival blockers (beyond the split)

- **Ability gate.** See decision 3.
- **Health regen.** The comment at `loop_1s.mcfunction:29` says the `natural_health_regeneration`
  gamerule is "set once in imperium:main", but no `gamerule` command exists anywhere in the pack.
  Check whether booth fights are meant to have regen off. For survival this is good news: nothing
  world-wide gets switched.
- **`clear_kit`** clears every `custom_data {imperium_kit:1b}` item. Survival craftables must
  **not** carry that marker, or switching kits would delete them.
- **`internal/contain`** claims and ages out arrows and potions marked `imperium_kit`. Survival
  arrows with Straight Flight need their own claim, or they'll hang in the air forever.
- **Stale Summit comments** in `internal/contain`, `grapple_track`, `mgrapple_track`, `loop_kit`,
  and the `im.fighting → summit.no_regen` leftover in `loop_1s`.

## Suggested order

1. **Commit the current state** (26.3 port + debug pass) as a baseline. Move the
   `test/probe_*` files out first.
2. **Add the hooks inside the single pack.** Same files, same folder, just route the calls through
   function tags. Test it: behaviour should be identical.
3. **Move files into three pack folders**, following the inventory above. No ID changes, if
   decision 1 is "keep `imperium:`".
4. **Test each combination:** core alone (clean log, nothing happens), core + kit PvP (identical to
   today), core + survival, all three.
5. **Start the survival content:** recipes, the gating from decision 3, the craftables.
