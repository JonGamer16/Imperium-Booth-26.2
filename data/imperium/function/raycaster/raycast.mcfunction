say raycast
execute \
    as @e[dx=0,type=!#minecraft:im.fencer_intangible,tag=!im.raycasting] \
    positioned ~-0.99 ~-0.99 ~-0.99 \
    if entity @s[dx=0] positioned ~0.99 ~0.99 ~0.99 \
    run function imperium:raycaster/collide

# Using a fake player name to hold a score
# Boom. Now we have primitive int variables at will
scoreboard players add .distance im_raycast 1

particle smoke ~ ~ ~ 0.0 0.0 0.0 0 0

# RANGE LIMIT
# Max range equals the increment [line 18] times the max .distance [line 17]
execute \
    if score .distance im_raycast matches ..5 \
    positioned ^ ^ ^0.1 \
    rotated ~ ~ \
    if block ~ ~ ~ #imperium:im.raycast_pass \
    run function imperium:raycaster/raycast