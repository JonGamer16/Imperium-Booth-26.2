clear @s tipped_arrow[custom_data~{imperium_kit:1b}]

execute \
    if items entity @s hotbar.8 * \
    run loot give @s loot imperium:levent/arrows

execute \
    unless items entity @s hotbar.8 * \
    run loot replace entity @s hotbar.8 loot imperium:levent/arrows

scoreboard players operation @s im_abilityCdA += #Levent im_abilityCdA
