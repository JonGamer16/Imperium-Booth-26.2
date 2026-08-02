# ARCHIVED 2026-08-02 — dead code, removed from imperium:single_use's post_attack effect.
#
# The enchantment itself is STILL LIVE, but as a tooltip label only: it puts the gold "Single Use"
# line (and the enchant glint) on Smokey's Marking Dart in loot_table/smokey/arrow. Its `effects`
# block was dropped, which is why this function no longer has a caller. Vanilla ships tooltip-only
# enchantments the same way (mending, silk_touch carry no `effects`).
#
# WHY IT WAS DEAD: the clear matches an item carrying BOTH minecraft:fire_aspect 1 AND
# imperium:single_use 1. Nothing in the live pack has ever had fire_aspect — the only other mention
# is ash_cutter's `exclusive_set`, one dir up, and exclusive_set means "cannot coexist with", so
# even that item wouldn't have matched. The Marking Dart, the sole holder of imperium:single_use,
# has no fire_aspect either. Net effect: the clear ran on every melee swing with a dart in hand and
# removed nothing, every time.
#
# DO NOT "FIX" THIS BY DROPPING fire_aspect FROM THE SELECTOR. That would make it match the dart,
# and post_attack fires on a melee swing — so meleeing anything while holding a dart would silently
# delete the dart. The dart is already spent correctly by its `consumable` component (eating it
# decrements the stack); kits/smokey/use_dart only spends the charge and fires the projectile.
#
# The `execute as @s` was also a no-op — @s is already the executor.
execute \
    as @s \
    run clear @s *[enchantments={"fire_aspect":1,"imperium:single_use":1}] 1
