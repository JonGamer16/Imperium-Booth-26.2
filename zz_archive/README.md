# zz_archive — parked enchantments (not loaded)

This folder sits at the datapack root, **outside `data/`**, so Minecraft never loads it
(the game only reads `data/` and `pack.mcmeta`). It holds enchantments that no current kit in the
7-kit roster uses, plus their exclusive support files, parked here on 2026-07-03 as a performance /
clutter cleanup. Code is preserved so any of these can be finished and re-enabled later.

## What's here (24 enchants + support)

- **Enchant defs**: `data/imperium/enchantment/*.json`
- **Support functions**: `data/imperium/function/enchantments/*.mcfunction`
- **Advancements** (drove unused mechanics): `barbs_hook`, `combat_hit` (fed the never-finished
  Brittle `brittle_flag`), `shield_pierce_hit`
- **Item modifier**: `apply_shield_pierce`

## Known-incomplete mechanics (were dead even before archiving)

- **shield_pierce** — wrote a non-existent `minecraft:damage_type` item component that nothing read;
  its advancement reward `imperium:enchantments/shield_pierce_apply` was never written.
- **brittle_curse / chinks_curse** — enchant defs reference tick functions
  (`imperium:enchantments/brittle`, `.../chinks_*`) that don't exist.

## To restore one enchant

Move its files back to the matching path under `data/` (e.g.
`zz_archive/data/imperium/enchantment/tipper.json` -> `data/imperium/enchantment/tipper.json`),
re-add it to the relevant kit's `givekit`/loot table, and — if it had an advancement — move that
back too. Enchant changes need a full quit-to-title + rejoin to apply (not just `/reload`).

Note: a handful of now-inert `scoreboard objectives add` lines for these enchants remain in
`data/imperium/function/main/enchantments.mcfunction`. They're harmless dead declarations; clean
them up if/when you delete an archived enchant for good.

---

# zz_archive — parked Gold Rush round machinery (not loaded)

Parked 2026-09-04, when the pack was converted from a Smithed Summit booth into a standalone
continuous free-for-all arena. Nothing here is broken; it is a complete, working round-based
gamemode that the current design has no caller for. Kept intact so Gold Rush can come back — either
inside the FFA arena or in a separate one.

## Why it was parked

Gold Rush was driven entirely by the Baobab Battlegrounds session lifecycle: a session became
active, players entered and left it, and it timed out. Standalone there is no session, and the FFA
model has no rounds at all — you jump off the spawn island, you fight, you die, you respawn, and
gold accumulates rather than resetting. Round start/end, lives, elimination, the end-of-round
leaderboard and the standings billboard have no meaning in that model.

## What's here

- **Round lifecycle**: `arena/start_round`, `arena/end_round`, `arena/round_over`,
  `arena/resolve_match`, `arena/eliminate`
- **Leaderboard**: `arena/lb_print`, `arena/lb_row`, `arena/lb_winner`, `arena/grant_win_sticker`
- **Standings billboard**: `arena/board_spawn`, `arena/board_update`, `arena/board_kill`
- **Unused helper**: `arena/arena_teleport` (had no caller even before the conversion)
- **Summit hooks**: everything that was `data/imperium/function/summit/` except `reset_player` —
  `player_enter`, `player_leave`, `player_died`, `booth_active`, `booth_inactive`, `end_fighter`,
  `assign_lastkit`, `register_booth`, `set_structure`
- **Booth registration**: `booth/register_booth`

`summit/reset_player` was NOT parked — it moved to `data/imperium/function/util/reset_player` and is
still the right "undo everything imperium put on this player" routine.

## What stayed live, and why

`arena/givekit`, `arena/lastkit`, `arena/calc_gold`, `arena/gold_dmg_bonus`, `arena/gold_kill_bonus`,
`arena/kill_feed`, `arena/on_death`, `arena/respawn`. FFA still kits players, still scores them,
still runs a kill feed and still handles death — it just doesn't wrap any of it in a round.

## What replaced the lifecycle

`imperium:ffa/join` and `imperium:ffa/leave`, driven by the safe-zone edges in `imperium:tick`:
stepping off the spawn island joins the fight, stepping back on leaves it. See those two files.

## To restore Gold Rush

Moving the files back under `data/` is NOT sufficient on its own — the callers are gone too:

1. Move the files back to their matching paths under `data/`.
2. Re-add `function imperium:arena/board_update` to `imperium:loop_1s`.
3. Give the round a start and end trigger. The Summit versions keyed off
   `summit.battlegrounds:database`; standalone needs something else (a button interaction wired like
   the kit stands, or a `/trigger`). `booth_active` / `booth_inactive` are the two entry points.
4. Decide how round-scoped gold coexists with persistent FFA gold — `start_round` zeroes
   `im_matchKills`, `im_stat*` and `im_gold*`, which is exactly what persistent gold must not do.
5. `arena/on_death` no longer spends `im_lives` or calls `arena/eliminate`; re-add both if you want
   elimination back.

---

# zz_archive — parked Summit integration (not loaded)

Parked 2026-09-04 alongside the Gold Rush machinery above, in the same standalone conversion.
Unlike that section, none of this is a gamemode worth restoring — it is the Summit server coupling
itself, kept only so the conversion is reversible and so the old behaviour is readable.

## What's here

- **`data/summit/`, `data/summit.battlegrounds/`, `data/summit.booth/`** — the eight function-tag
  files that registered this pack's functions into Summit's API hooks. Standalone they point at
  functions that are themselves parked. Note `summit.booth` was *generated* server-side from
  `booth_definition.json`; the copies here are only what this pack contributed to it.
- **`function/util/inv_*`** (`inv_cache`, `inv_restore`, `inv_return`, `inv_return_tick`) — the
  inventory cache. Wrapped `summit.inventory_management:save`/`load`, a shard-synced server API.
  **Not reimplementable as-is**: vanilla cannot write a player's `Inventory` back via `/data`. A
  standalone version needs a stash container plus per-slot `item replace block ... from entity @s`.
- **`function/kits/*/booth/assign`** (×7) — `summit.battlegrounds:api/assign_kit/v2` calls that told
  the Battlegrounds which kit a player had picked. The pack's own `im_lastKit` score already tracks
  this, and `arena/givekit` writes it, so nothing was lost by dropping them.
- **`predicate/battlegrounds.json`** — `im.fighting` AND `summit.battlegrounds.player`. The second
  tag no longer exists; `im.fighting` alone is now the test, applied by `imperium:ffa/join`.
- **`predicate/in_bounds.json`** — booth + arena + corridor containment. Went unused when the ability
  gate became "is holding a kit" rather than "is inside the build"; see `internal/contain`.
- **`predicate/warp_landing.json`** — the kit-room landing box, read only by the old `exit_booth`
  kit-strip exemption. That whole path is gone.

## Not parked, worth knowing

- `summit/reset_player` moved to **`function/util/reset_player`** and is still useful — it is now a
  manual repair tool (`/execute as <player> run function imperium:util/reset_player`) rather than a
  hook, since nothing calls it automatically without Summit's `/hub` and `/unstuck`.
- The **sticker book** was not parked, it was removed. It was generated from
  `booth_definition.sticker_book` and was a Summit booth feature rather than anything this pack
  owned. `booth/check_lore` keeps the seven `im.lore_<kit>` tags and prints its own completion
  message; those tags are the natural feed for kit unlocks later.
- If Gold Rush is restored, `arena/grant_win_sticker` still references
  `summit.sticker_book:imperium/win_fight` and will need that line replaced or removed.
