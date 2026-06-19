clear @s splash_potion[custom_data~{imperium_kit:1b}]

execute \
    if items entity @s hotbar.2 * \
    run loot give @s loot imperium:livvy/potion

execute \
    unless items entity @s hotbar.2 * \
    run loot replace entity @s hotbar.2 loot imperium:livvy/potion

scoreboard players operation @s im_abilityCdC += #Livvy im_abilityCdC