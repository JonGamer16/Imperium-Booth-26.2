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
