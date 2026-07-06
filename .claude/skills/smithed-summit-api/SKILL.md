---
name: smithed-summit-api
description: Reference for Smithed Summit event server integration and Baobab Battlegrounds booth development. Use for any questions about Summit Assets, Battlegrounds API, booth definition/schematics, interactions API, predicates, entity/function tags, ticking systems, sticker books, and balloons.
---

# Smithed Summit API Reference

Comprehensive documentation for integrating datapacks with the Smithed Summit event server and developing for the Baobab Battlegrounds. These reference files contain the API specifications, booth setup guidelines, and asset information.

## Available Reference Files

When working on Smithed Summit or Baobab Battlegrounds tasks, consult the Summit Handbook.md in `.claude\Smithed API\Summit Handbook.md`

## Server Constraints (Summit staff rules)

Hard rules enforced by Summit staff — follow these when authoring or reviewing pack files:

- **Do not overwrite vanilla content in the `minecraft` namespace.** Any file under `data/minecraft/` that shares an id with vanilla content (enchantments, recipes, loot tables, advancements, vanilla tag *entries*) is a prohibited override.
  - **Enchantments:** never override `data/minecraft/enchantment/*`. Define a custom enchant in the `imperium` namespace instead (e.g. vanilla Power doesn't work on crossbows → use `imperium:crossbow_power` and put it on the item).
  - **Damage-type tags must stay additive and custom-only.** Custom damage types can *only* join vanilla tags (`no_impact`, `bypasses_shield`, `bypasses_cooldown`, etc.) via a file at that exact `data/minecraft/tags/damage_type/<tag>.json` path — there is no other namespace that works, and that's allowed *as long as the file lists only `imperium:` damage types*. Adding **vanilla** damage types (`minecraft:magic`, `wither`, `arrow`, …) to those tags is a prohibited global override of vanilla behavior — strip them and find a per-mechanic workaround.
  - **Recipes / other vanilla tags** (e.g. `tags/enchantment/curse`) under `minecraft/` are overrides too — avoid them.
  - **Allowed exception:** `data/minecraft/tags/function/load.json` and `tick.json` are the required datapack load/tick hooks, not overrides — keep them.
- **No-impact / i-frame-bypass without overriding vanilla:** a damage type only gets no-flinch / cooldown-bypass behavior from the vanilla `#no_impact` / `#bypasses_cooldown` tags. To get it for a mechanic that normally uses a vanilla damage type (e.g. poison = `minecraft:magic`), deal a **custom `imperium:` damage type** via a small DoT instead, and add only that custom type to the tag (see Livvy's `imperium:venom`).
- **Prohibited status effects:** Glowing is banned. Prefer **entity tags** (with a scoreboard timer) over status effects for tracking marks/states (see Smokey's `im.marked`, Livvy's `im.venom`).

## When to Use This Skill

**Use this skill when:**
- Developing booth logic for Smithed Summit integration
- Working with Baobab Battlegrounds game mechanics
- Implementing interactions, predicates, or function tags for Summit compatibility
- Setting up booth definitions or schematics
- Handling ticking systems or game loops
- Working with Summit assets or cosmetic systems

**Reference the relevant file(s)** in your responses, and answer from that content to ensure accuracy with the server's systems.
