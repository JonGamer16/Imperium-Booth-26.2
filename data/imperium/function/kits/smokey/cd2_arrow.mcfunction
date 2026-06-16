clear @s arrow[custom_data={imperium_kit:1b}]

execute \
    if items entity @s hotbar.2 * \
    run loot give @s loot imperium:smokey/arrow

execute \
    unless items entity @s hotbar.2 * \
    run loot replace entity @s hotbar.2 loot imperium:smokey/arrow

scoreboard players operation @s im_abilityCdB += #Smokey im_abilityCdB
scoreboard players operation @s im_cdUsesB = #Smokey im_cdMaxB
scoreboard players operation @s im_cdFloorB = #Smokey im_cdFloorB
scoreboard players operation @s im_cdMaxB = #Smokey im_cdMaxB
