scoreboard players add @s im_backstabraycast 1

# Check for direct hitbox intersection instead of distance to feet
execute \
    if entity @e[type=!player,type=!#minecraft:im.not_mob,dx=0,dy=0,dz=0,limit=1,sort=nearest] \
    run function imperium:enchantments/backstab_calc

# Continue loop
execute \
    if score @s im_backstabflag matches 0 \
    if score @s im_backstabraycast matches ..15 \
    positioned ^ ^ ^0.33 \
    if block ~ ~ ~ #imperium:im.raycast_pass \
    run function imperium:enchantments/backstab_raycast