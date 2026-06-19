clear @s cobweb[custom_data~{imperium_kit:1b}]

execute \
    if items entity @s hotbar.1 * \
    run loot give @s loot imperium:livvy/web

execute \
    unless items entity @s hotbar.1 * \
    run loot replace entity @s hotbar.1 loot imperium:livvy/web

scoreboard players operation @s im_abilityCdB += #Livvy im_abilityCdB
