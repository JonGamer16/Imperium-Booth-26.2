#execute \
#    as @e[dx=0,type=!#im.not_mob] \
#    positioned ~-0.99 ~-0.99 ~-0.99 \
#    if entity @s[dx=0] \
#    positioned ~0.99 ~0.99 ~0.99 \
#    run scoreboard players set \
#        @e[type=#imperium:human,distance=..6,sort=furthest,limit=1] im_tipperraycast 500

#execute \
#    if entity @e[distance=0..0.1,type=!#im.not_mob] \
#    if block ~ ~ ~ #imperium:im.raycast_pass \
#    run scoreboard players add @s im_tipperraycast 25

# execute \
#     positioned ~ ~ ~ \
#     if entity @e[distance=0..0.1,type=!#im.not_mob] \
#     if block ~ ~ ~ #imperium:im.raycast_pass \
#     run say +

# increment the player's raycast step first so a collision copies a non-zero value
scoreboard players add @s im_tipperraycast 1

# check if an entity collides with the line, if yes then copy the player's current raycast step
execute \
    if entity @e[distance=0..0.99,type=!#minecraft:im.not_mob] \
    run scoreboard players operation \
        @s im_tipperdistance \
        = @s im_tipperraycast

execute \
    as @e[dx=0,type=!#im.not_mob] \
    positioned ~-0.99 ~-0.99 ~-0.99 \
    if entity @s[dx=0] \
    positioned ~0.99 ~0.99 ~0.99 \
    run scoreboard players operation \
        @p[sort=nearest,limit=1] im_tipperdistance \
        = @p[sort=nearest,limit=1] im_tipperraycast

# loop
execute \
    if entity @s[scores={im_tipperraycast=..51}] \
    positioned ^ ^ ^0.1 \
    if block ~ ~ ~ #imperium:im.raycast_pass \
    run function imperium:enchantments/tipper_raycast
# exit loop
scoreboard players reset @s[scores={im_tipperraycast=1..}] im_tipperraycast