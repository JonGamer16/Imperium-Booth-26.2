clear @s lingering_potion[custom_data={imperium_kit:1b}]

execute \
    if items entity @s hotbar.3 * \
    run loot give @s loot imperium:smokey/potion

execute \
    unless items entity @s hotbar.3 * \
    run loot replace entity @s hotbar.3 loot imperium:smokey/potion

scoreboard players operation @s im_abilityCdC += #Smokey im_abilityCdC
