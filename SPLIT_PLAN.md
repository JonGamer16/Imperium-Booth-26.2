# Three-pack split — plan

Status: **step 2 done (core/load, core/tick, core/second inside the single pack), awaiting in-game test** (2026-10-27). This file is the inventory and the
coupling map to work from. Recent changes are in [CHANGELOG.md](CHANGELOG.md).

## Goal

Make as much of Imperium as possible playable in a normal survival world, and add craftable weapons
and items, without breaking the kit-PvP game. Split the one pack into three:

| Pack | Working name | Contents | Needs |
|---|---|---|---|
| **Core** | `imperium` | Hand-picked enchantments and items that work without kits, the motion library, shared objectives and constants | — |
| **Kit PvP** | `imperium_kitpvp` | The 7 kits, the cooldown engine, ability gating, gamerules, booth, arena / FFA, gold, dummy, kit-exclusive enchantments | Core |
| **Survival** | `imperium_smp` | Recipes, loot injections, new craftables, and its own balancing (e.g. a shared mana bar) | Core |

Core must load and run cleanly **on its own**, and must never change world-wide settings. That way
it can sit next to other packs in someone's survival world.

## Decisions (made 2026-10-27)

1. **Namespace: keep `imperium:` in all three packs**, with disjoint file paths. Data packs merge a
   namespace across packs, so moving a file between packs changes **no IDs** and rewrites no
   references. A pack can still be renamed later on its own if needed.
2. **The cooldown engine and ability gating are kit-PvP only.** That covers `update_cooldowns`,
   `set_cd`, `kit_dispatch`, the `combat/cooldown_*` triggers, `imperium:ability_zone` and
   `im.kitted`. Survival items get a different balancing system: a shared, chargeable mana bar that
   everything spends from, or something else. That's designed later, in the survival pack.
3. **Gamerules and other world-wide settings live in kit PvP.** Core and survival must not set any.
   Kit PvP turns natural regen off: `gamerule natural_health_regeneration false` in `main`, added
   2026-10-27. The `loop_1s` comment always said it was set there, but the line was missing.
4. **Enchantments and items are hand-picked.** Kit-tied ones stay exclusive to kit PvP. Self-contained
   ones go to core, so survival can use them. Anything that would need a near-full rewrite to work
   without a kit stays in kit PvP until it's rebuilt for survival.
5. **One game mode per world.** A world runs kit PvP *or* survival, never both. So sharing `im.temp`
   (created by core) is fine, and survival items **may** keep the `imperium_kit` custom_data marker:
   kit PvP's `clear_kit` / `internal/contain` never meet them in the same world. If that ever
   changes, give survival its own loot-table entries with a separate marker such as
   `{imperium_smp:1b}`.

## Inventory — where each piece goes

### Core (`imperium`): small, self-contained

| Path | Notes |
|---|---|
| `function/motion/*` | Launch library. Kit PvP calls into it, which is the allowed direction. |
| `enchantment/{backstab, crits, crossbow_power, crossbow_punch, high_jump, mace_smash, marked, motion_impulse, single_use, straight_flight, volley}` | Self-contained effects. None reference kits, the engine or `ability_zone` (checked 2026-10-27). |
| `function/enchantments/{backstab, backstab_behind, high_jump, high_jump_on, high_jump_off, straight_flight, volley_hit, volley_land, volley_spawn}` | Called only by those enchantments' own effects. Kit PvP also calls `high_jump_off`, which is fine. |
| `damage_type/volley_reset`, `minecraft/tags/damage_type/*`, `minecraft/tags/enchantment/*` | Tags merge across packs, but each pack's copy may list only its own IDs (see the kit PvP `damage_type` row). |
| `function/main/constants` | `imperium.const`. Idempotent, so any pack's load can call it. |
| `function/core/{load, tick, second}` | **Done.** `load` creates `im.temp`, `im.motion`, backstab + high-jump objectives, `im_arrowAge`, `imperium.const`. `tick` runs the High Jump unequip watchdog (moved out of `kits/levent/loop_kit`) and its own `#core1s` clock; `second` ages Straight Flight arrows by tag. |
| `predicate/floating`, `tags/entity_type/human` | Used by High Jump and Backstab. No other predicate is used by a core file (checked 2026-10-27). |

`marked` reads the `im.marked` tag, which only the Smokey dart applies. In core it does nothing until
something in survival applies the tag. That's harmless, but keep it in mind.

### Kit PvP (`imperium_kitpvp`): almost everything else

| Path | Notes |
|---|---|
| `function/kits/*` (140 files), `kit_dispatch` | All 7 kits. |
| `function/update_cooldowns`, `abilities/*`, `internal/*` | The cooldown engine, leap, and every shared trigger. |
| `function/tick`, `loop_tick`, `loop_5t`, `loop_1s`, `loop_enchantments` | The driver and loops. They're nearly all kit, booth or arena work. Only Straight Flight's aging moves to core. |
| `function/booth/*`, `arena/*`, `ffa/*`, `util/*`, `test/*` | Booth, gold, respawn, kill feed, kit utilities, debug toggles. |
| `function/main.mcfunction`, `main/{ability_cooldowns, ability_parameters, enchantments, game_triggers, init_cooldowns, init_stats}` | Kit PvP's load. It should call `imperium:main/constants` and rely on core's load for the rest. |
| `function/enchantments/{reversal*, offhand_*, lifesteal*, aim_*}` | Kit-gated. |
| `enchantment/{reversal, offhand_attack, lifesteal, focus_attack, charge_attack, golem_throw, barrier, grappling, reeling, leap}` | These call kit functions, or are tooltip markers for kit trackers. |
| All of `advancement/*` | Every current advancement is kit, booth or engine. Core needs none. |
| `predicate/{ability_zone, safe_zone, at_spawn, has_bad_omen, has_venom, booth/*}` | |
| `loot_table/<kit>/*`, `item_modifier/*`, `dialog/*`, `structure/*`, `sync_setting/*`, `damage_type/{light, bomb, venom}` | `light` is the Rastus rapier's i-frame bypass. Move it to core if a survival item wants it. |
| `minecraft/tags/entity_type/*`, `minecraft/tags/function/{tick, load}` | Function tags merge, so core adds its own entries (`core/load`, `core/tick`). |
| `minecraft/tags/damage_type/*` | **Split per pack.** `bypasses_cooldown` lists `light`, `venom` (kit) and `volley_reset` (core). Core's copy must list only `volley_reset`, or the tag fails to load when core runs alone. |

### Survival (`imperium_smp`)

| Path | Notes |
|---|---|
| `recipe/*` | The 3 existing recipes (diamond dagger / glaive / rapier) predate 26.2 and need fixing. The glaive's `item_name` is a JSON string. |
| `loot_table/smp_weapons/` | Already exists, but empty (created 2026-10-27). |
| *(new)* | Mana bar or other balancing, craftables, loot injections, survival versions of any kit abilities worth porting. |

## Coupling to cut

With the engine and gating in kit PvP, almost every dependency already runs **kit PvP → core**,
which is allowed. Only these need work:

| Issue | Fix |
|---|---|
| ~~High Jump's unequip watchdog lived in `kits/levent/loop_kit`~~ | Done: moved to `core/tick`. Must run exactly once per tick, or it flickers gravity. |
| Straight Flight arrows are only aged and despawned via kit PvP: `internal/contain` claims `imperium_kit` arrows as `im.owned`, and `loop_1s` ages `im.owned`. In core alone (or survival), a Straight Flight arrow would hang in the air forever. | Core's `core/second` ages `@e[type=#minecraft:arrows,tag=im.straight_flight]` itself. Kit PvP's `im.owned` aging stays as it is for its other arrows. An arrow aged by both still dies at 10 s; check the counts don't double. |
| `main.mcfunction` creates every objective for every system. | Split it: `core/load` creates core's objectives, kit PvP's `main` creates the rest. |
| `im.temp` is shared scratch space (used by both volley and the kits). | Created by `core/load`. Kit PvP keeps using it (decision 5). |
| `util/rearm_triggers` lists every advancement. | All advancements are kit PvP, so it stays there as it is. |

**Watch out:**
- A function tag that lists a function which doesn't exist fails to load as a whole. Each pack's
  tag entries must point only at that pack's own files. Where an entry may legitimately be missing,
  write it as `{"id": "imperium:...", "required": false}`.
- **Load order:** packs' `#minecraft:load` entries run in pack order. Kit PvP's load must not read a
  core objective before core's load creates it. Simplest fix: kit PvP's `main` calls
  `function imperium:core/load` first; it's idempotent.

## Open questions

- **Which kit abilities to port to survival.** Candidates that are mostly self-contained: Smokey's
  grapple (`grappling`), Livvy's web, Mummy's crystal bomb, the leap feather. Each needs its kit-tag
  gates and slot-engine refills replaced by the survival balancing system.
- **Stale Summit comments** in `internal/contain`, `grapple_track`, `mgrapple_track` and
  `smokey/loop_kit`, plus the `im.fighting → summit.no_regen` leftover in `loop_1s`. Clean up
  while moving files.

## Suggested order

1. **Commit the current state** (26.3 port + debug pass) as a baseline. Move the
   `test/probe_*` files out first.
2. **Add `core/load` and `core/second` inside the single pack**, with Straight Flight aging by its
   own tag. Test: behaviour should be identical.
3. **Move files into three pack folders**, following the inventory above. No ID changes.
4. **Test each combination:**
   - core alone: clean log, the core enchantments work on hand-enchanted items, no gamerule
     changes,
   - core + kit PvP: identical to today,
   - core + survival,
   - all three.
5. **Start the survival content:** recipes, item markers, the mana bar, the craftables.
