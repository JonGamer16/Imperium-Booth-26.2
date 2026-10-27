# Changelog

Newest first. Dates are when the change was made in the test world. The matching commit, once
there is one, carries the same date in its title.

## 2026-10-27 — 26.3 port + debug pass

Ported to Minecraft Java **26.3** (data pack format 121) for the pack collab, then played through
every kit and fixed what came up. Everything below has been tested in-game unless marked
*(untested)*.

### Port to 26.3

- `pack.mcmeta` declares `min_format: [121, 0]`, `max_format: 121`. Since 1.21.9 these two fields are
  required, and `pack_format` / `supported_formats` must be left out.
- **111 JSON files migrated by script.** That covers 9 enchantments, 15 predicates, all 32
  advancements, 64 loot tables and 1 item modifier.
  - Loot conditions: `condition` → `type`.
  - `minecraft:reference` → a bare predicate ID string.
  - Lists of conditions → `all_of`.
  - The entity-predicate shorthand in advancement fields → an explicit `entity_properties`.
  - `value_check` → `int_value_check`, with `range` → `test`.
  - Loot tables: `function` → `type`, `functions` → `modifier`, `conditions` → `condition`.
- **Fixed by hand:**
  - The `marked` enchantment's `requirements` was a list. It's a single condition now.
  - Block-state NBT `Name` / `Properties` → `id` / `properties`, in `booth_entities/fake_blocks`
    and `livvy/web_init`.
  - Damage-type tag checks need a `#` now: `#minecraft:no_impact` in `venom_bite`, and
    `#imperium:kinetic` in `use_kinetic_weapon`. The second one meant Smokey's kinetic charge
    never fired.
  - Smokey's givekit failed to load. The `swing_animation` component was removed and replaced by
    `attack_animation` + `interact_animation`. Both items now set both, which keeps the 26.2 look.
- Checked against every other 26.3 breaking change (`map_color`, `pot_decorations`, the
  `potion_contents` predicate, multi-slot `/item replace`, sign click events, recipe
  `cookingtime`, ...). None of them affect this pack.
- `spyglass.json` now targets game version 26.3.

### Cooldown engine

- **Fixed: "you have to take damage before cooldowns move."** `combat/cooldown_dealt` only fired
  on human targets, but the `damage_dealt` stat counts every target. Damage dealt to mobs piled up
  in `im_abilityDealt` until the next `cooldown_taken` run spent all of it at once.
- **New rule: every target charges cooldowns.** Hits on `#imperium:human` (players, mannequins,
  the dummy husk) count 1:1. Any other mob counts **1/3**. Damage taken stays 1:1.
  - `combat/cooldown_dealt` fires on any target.
  - The new `combat/cooldown_dealt_human` tags hits on humans.
  - The engine runs **one tick later**, from `internal/cooldown_flush` →
    `cooldown_dealt_apply`. The trigger may fire before vanilla adds the hit to the stat, so the
    delay makes sure the hit is counted.
  - A sweep that hits a human and a mob in the same tick counts entirely as human.
- `update_cooldowns` creates the two damage scores at 0 if they're missing. Subtracting a score
  that doesn't exist fails, which froze cooldowns for players who had never taken damage.
- **New: `util/rearm_triggers`.** It revokes every self-revoking `imperium:` advancement by name,
  and runs on load and on every kit equip. An advancement whose reward function failed (during
  the port, for example) stays granted forever, and its trigger silently stops working. Smokey's
  break-reel launch and Levent's first reversal both started working after it was added. It most
  likely cleared stuck triggers, but that wasn't confirmed directly.
  **Add a line to it whenever you add an advancement.**

### Kit changes

- **Smokey — Marking Dart** marks any mob it hits, not just players. That includes the dummy and
  golems, and survival mobs later. The red mark particles are now shown to everyone holding a kit,
  not only FFA fighters. *(untested)*
- **Mummy — Grapple Rod** no longer hooks things it only touched. A target counts as hooked only
  if the bobber is on its center line (within 0.4 blocks on each horizontal axis) and 0.3–3
  blocks above its feet. See `kits/mummy/mgrapple_hook_test`. The old check counted anyone whose
  hitbox came within half a block of the bobber.
- **Rastus — combo tax.** Landing `#ComboHits` (3) hits within `#ComboWindow` (20 ticks) of the
  first one spends 1 dash. At 0 dashes, the rapier drops to about 2 attacks/s (a −75% player
  attack-speed modifier, `imperium:combo_slow`) until a dash recharges. Only landed hits count;
  this is intentional.

### Test tools (`function/test/`)

| Function | What it does |
|---|---|
| `test/toggle_zone` | Flips `#ZoneBypass im.dmg`. While on, `imperium:ability_zone` passes for every player, kit or not. |
| `test/toggle_cd_trace` | Flips `#CdTrace im_debug_mode`. While on, each engine run prints its trigger, the hit weighting and its inputs, and the grapple break path prints too. |
| `test/cd_trace` | Prints one line with the cooldown engine's inputs for `@s`. |

Both toggles keep their value across `/reload`. Turn them off before a real session.

### World settings

- **`main` now runs `gamerule natural_health_regeneration false`.** The `loop_1s` regen comment always
  said this line existed, but it was missing, so natural regen was on during fights. Kit PvP only:
  after the split it stays in the kit PvP pack's load. *(untested)*

### Housekeeping

- The Smithed Summit constraints are retired. The pack is a standalone game now, so the
  "never touch other booths' entities" rule no longer applies. Some code comments still mention
  it; they can be cleaned up during the pack split.
- `advancement/test/probe_*` and `function/test/probe_*` are temporary debugging probes. Move them
  out before the split.
