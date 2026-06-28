# Imperium Booth — Datapack Notes

Kit-PVP datapack for the Imperium Mundi booth. Vanilla data pack (no mods).

## Target version: Minecraft Java 26.2

`pack.mcmeta` declares `pack_format` 107.1 (supported 100–1000). **Use 26.2 syntax**, which
changed several predicate/enchantment formats from earlier versions. Verify against the local
wiki (`/minecraft-wiki` skill) before assuming older syntax is valid.

### 26.2 predicate changes (these bite often)

- **Type-specific sub-predicates are flattened to top-level keys.** Use
  `"type_specific/player": { ... }` directly inside `predicate`, NOT the old nested
  `"type_specific": { "type": "minecraft:player", ... }`. Same for `type_specific/fishing_hook`,
  `type_specific/raider`, `type_specific/cube_mob` (formerly `slime`), etc. The `minecraft:`
  namespace prefix is optional.
- **Unrecognized sub-predicate fields are now REJECTED, not ignored.** A typo'd or wrong field
  name (e.g. `inGround` on a player instead of `OnGround`) fails the *entire* predicate to load.
  A predicate that fails to load is silently treated as "unknown/absent."
- `nbt` accepts either an SNBT string (`"{OnGround:0b}"`) or a compound object. Prefer the
  string form for byte flags like `OnGround` to avoid bool→byte ambiguity.

### Referencing predicates

- To invoke a predicate *file* as a condition, use
  `{ "condition": "minecraft:reference", "name": "imperium:<id>" }`.
- `entity_properties.predicate` only accepts an **inline** sub-predicate object — it does NOT
  accept a predicate-ID string.
- **`minecraft:reference` CANNOT be used inside enchantment definitions.** Inline the predicate
  conditions directly into the enchantment's effect `requirements` instead. `minecraft:inverted`,
  `all_of`, and `any_of` ARE allowed in enchantments.

### Enchantments

- For effects (incl. `minecraft:tick`) to fire, the item must be equipped in a slot listed in
  `slots`. Match `slots` to `supported_items`: armor enchants need `["armor"]` (or a specific
  armor slot), not `["mainhand"]`.
- Prefer fully-qualified effect keys (`minecraft:tick`, `minecraft:damage_protection`).
- **Enchantment changes do NOT reliably apply on `/reload`** — definitions are cached. Quit to
  the title screen and rejoin the world (and re-apply/re-select the item) to test changes.
