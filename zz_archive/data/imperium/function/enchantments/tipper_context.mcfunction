# get reach
execute \
    as @s \
    store result score @s im_reach \
    run attribute @s entity_interaction_range get 10
# calc sourspot: reach / 3
execute \
    store result score @s im_sourspot \
    run scoreboard players get @s im_reach
scoreboard players operation @s im_sourspot /= const 3
# calc sweetspot: reach / 5
execute \
    store result score @s im_sweetspot \
    run scoreboard players get @s im_reach
execute \
    store result score @s im_reach \
    run scoreboard players operation @s im_reach /= const 5
scoreboard players operation @s im_sweetspot -= @s im_reach
# run tipper
execute \
    as @s \
    run function imperium:enchantments/tipper

#execute \
     at @s \
     if items entity @s weapon *[minecraft:enchantments~[{enchantments:"imperium:tipper"}]] \
     run say working

# execute \
#     store result score @s im_sweetspot \
#     if items entity @s weapon *[minecraft:enchantments~[{enchantments:"imperium:tipper"}]] \
#     run scoreboard players get @s im_reach