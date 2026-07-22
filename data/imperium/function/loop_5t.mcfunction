#### 5-TICK LOOP (kit & booth interface) ####
#
# Low-frequency UI/menu work that doesn't need per-tick responsiveness. In the Summit this is
# driven by booth_definition ticking_functions ("imperium:loop_5t": "5t"), so it only ticks while a
# player is inside the booth bounds. For the local test world it's driven by the #t5 clock at
# the bottom of imperium:loop (same convention as imperium:loop_1s).
#
# Kit-stand selection is now advancement-driven (imperium:booth/select_<kit> ->
# kits/<kit>/booth/click), so it no longer polls here.

# Training dummy upkeep (this loop only ticks while someone's in the booth — exactly when
# the dummy matters).

    # Auto-reset: respawn a missing dummy (edge-killed or slain by players) at its home marker.
    execute unless entity @e[type=husk,tag=im.dummy] as @e[type=marker,tag=im.dummy_home,limit=1] at @s run function imperium:booth/dummy/respawn

    # Tether: knocked/lured 10+ blocks from every home marker -> snap back to the nearest one.
    execute as @e[type=husk,tag=im.dummy] at @s unless entity @e[type=marker,tag=im.dummy_home,distance=..10] run tp @s @n[type=marker,tag=im.dummy_home]

    # Edge guard: kill it within 3 blocks of the booth bounds (dummy_zone = pagoda_center
    # shrunk by 3 on x/z); the auto-reset above brings it back next cycle.
    execute as @e[type=husk,tag=im.dummy] at @s unless predicate imperium:booth/dummy_zone run kill @s

# Battlegrounds teleport pad: any player within 2 blocks of an im.warp_from_kitroom marker
# gets sent to the destination below. TODO: replace 0 100 0 with the real coords.
    execute as @e[type=marker,tag=im.warp_from_kitroom,limit=1] at @s as @a[distance=..2] run tp @s -119 71 99 -90 0

    execute as @e[type=marker,tag=im.warp_from_shulkerbox,limit=1] at @s as @a[distance=..2] run tp @s -68.5 87 -7.5 90 0