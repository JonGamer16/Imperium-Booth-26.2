# Chorus Fruit blink — reward of imperium:levent_chorus (fires as @s = the eater). Replaces the
# old teleport_randomly (which flung players out of bounds) with a controlled forward blink that
# will not pass through blocks. Reuses Reversal's safety check: a spot is clear only if BOTH the
# feet block and the head block there are #minecraft:replaceable.

# Re-arm the detector so the next chorus fruit can trigger it again.
advancement revoke @s only imperium:levent_chorus

# Only Levent should blink (other kits share the imperium_healing custom_data flag). Gate on the
# kit tag, mirroring Reversal — this is the reliable per-player check.
execute unless entity @s[tag=im.kit_levent] run return fail

# Walk forward one block at a time from the player's feet, flattening pitch so the blink stays
# horizontal and never clips up or down (same framing Reversal uses). Each hop moves the anchor
# one block ahead, verifies that spot's feet + head are replaceable, then teleports the player
# onto it. A blocked hop simply doesn't run, so the player stops at the last clear block — every
# later hop tests the same blocked spot and also stops, capping the blink there. Range: 5 blocks.
execute at @s rotated ~ 0 positioned ^ ^ ^1 if block ~ ~ ~ #minecraft:replaceable if block ~ ~1 ~ #minecraft:replaceable run tp @s ~ ~ ~
execute at @s rotated ~ 0 positioned ^ ^ ^1 if block ~ ~ ~ #minecraft:replaceable if block ~ ~1 ~ #minecraft:replaceable run tp @s ~ ~ ~
execute at @s rotated ~ 0 positioned ^ ^ ^1 if block ~ ~ ~ #minecraft:replaceable if block ~ ~1 ~ #minecraft:replaceable run tp @s ~ ~ ~
execute at @s rotated ~ 0 positioned ^ ^ ^1 if block ~ ~ ~ #minecraft:replaceable if block ~ ~1 ~ #minecraft:replaceable run tp @s ~ ~ ~
execute at @s rotated ~ 0 positioned ^ ^ ^1 if block ~ ~ ~ #minecraft:replaceable if block ~ ~1 ~ #minecraft:replaceable run tp @s ~ ~ ~

# Arrival flavor (mirrors Reversal's warp feedback).
execute at @s run particle minecraft:reverse_portal ~ ~1 ~ 0.3 0.6 0.3 0.05 30
execute at @s run playsound minecraft:entity.enderman.teleport player @a ~ ~ ~ 1 1.5
