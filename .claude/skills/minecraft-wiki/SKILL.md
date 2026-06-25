---
name: minecraft-wiki
description: Look up Minecraft game content from a local offline Minecraft Wiki dump (~51k pages). Use for any Minecraft question — blocks, items, mobs, biomes, structures, crafting/smelting/brewing recipes, redstone, commands, datapacks (loot tables, predicates, recipe/advancement formats), Java vs Bedrock differences, and version history. Also use to verify whether an unfamiliar item/mob/mechanic actually exists before concluding it doesn't.
---

# Minecraft Wiki Reference

A local offline snapshot of the Minecraft Wiki (~51k pages), maintained in the bundled
`MinecraftWikiScrape` repo. When answering a Minecraft question, **look up the relevant
page(s) first**, answer from that content, and cite the wiki URL.

If something seems unfamiliar or like it doesn't exist (an unknown item, mob, biome, or
mechanic), **check the wiki before concluding it isn't real** — it may be a new, upcoming,
or obscure feature.

## Lookup tool

Use `wiki.py` from the bundled repo. Run with `python` or `python3`, whichever exists.
Paths below are relative to the project root — adjust the prefix if your cwd differs.

```bash
# Search page titles by keyword
python .claude/MinecraftWikiScrape/wiki.py title "piston"

# Search by category (e.g. Blocks, Mobs, Items, Mechanics)
python .claude/MinecraftWikiScrape/wiki.py cat "Mobs"

# Read a page's full content (follows redirects automatically)
python .claude/MinecraftWikiScrape/wiki.py page "Piston"

# Full-text search inside page content
python .claude/MinecraftWikiScrape/wiki.py search "blast resistance"
```

The tool resolves its own data path (`MinecraftWikiScrape/data/pages.json`), so it works
from any working directory.

## Important rules

- **Always include the wiki URL** in your response so the user can read the full page.
- **Prefer exact title match** (`page`) over keyword search when you know the page name;
  `page` follows one redirect automatically.
- **Check categories** on a matched page to confirm it's the right article (e.g. a mob vs.
  an item with the same name).
- Content is **wikitext** — recipes appear as `{{Crafting|A1=...|B2=...}}` templates;
  parse the grid by slot (A/B/C = columns, 1/2/3 = rows).

## Debugging gotchas

- **Enchantment changes need a full world restart, not just `/reload`.** When debugging an
  enchantment (its JSON, its effects, or anything that fires through it) and no clear cause
  turns up in the code, **remind the user to quit to the title screen and rejoin the world**
  before concluding the change is broken. Enchantment definitions are loaded/cached such that
  `/reload` alone does not reliably apply edits — re-applying the item or re-selecting a kit
  is also not enough. A quit-and-rejoin is the reliable test.

## Updating the data

The snapshot lives in `.claude/MinecraftWikiScrape/data/pages.json` (metadata in the sibling
`meta.json`). Re-run `scraper.py` in that repo to refresh.
