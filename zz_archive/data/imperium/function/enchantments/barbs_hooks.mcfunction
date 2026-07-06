# Barbs hook processing — global, runs once per tick from imperium:loop (gated on a barbs_user
# existing). Operates on bobber/entity tags only (no item-component matching), so it's cheap to run
# once regardless of how many players hold a barbs rod. Holders are flagged by the enchant tick
# effect (imperium:enchantments/barbs -> barbs_user).

# 1. Tag newly cast bobbers belonging to a barbs user (proximity check at spawn).
execute \
    as @e[type=fishing_bobber,tag=!checked] \
    at @s \
    if entity @a[tag=barbs_user,distance=..3] \
    run tag @s add barbed_bobber
tag @e[type=fishing_bobber,tag=!checked] add checked

# 2. Detect entities caught by the barbed bobber.
execute \
    as @e[type=fishing_bobber,tag=barbed_bobber] \
    at @s \
    run tag @n[distance=0.1..1.5,type=!player] add hooked_by_barbs

# 3. Apply damage once per hook (2 damage = 1 heart) attributed to the nearest user.
execute \
    as @e[tag=hooked_by_barbs,tag=!barbs_damaged,type=!#im.not_mob] \
    run damage @s 2 minecraft:player_attack \
        by @p[tag=barbs_user]
tag @e[tag=hooked_by_barbs] add barbs_damaged

# 4. Reset entity tags when the bobber is no longer attached.
execute \
    as @e[tag=hooked_by_barbs] \
    at @s \
    unless entity @e[type=fishing_bobber,tag=barbed_bobber,distance=..2] \
    run tag @s remove barbs_damaged
execute \
    as @e[tag=hooked_by_barbs] \
    at @s \
    unless entity @e[type=fishing_bobber,tag=barbed_bobber,distance=..2] \
    run tag @s remove hooked_by_barbs
