clear @s feather[custom_data={imperium_kit:1b}]

execute \
    if items entity @s weapon.offhand * \
    run loot give @s loot imperium:livvy/feather

execute \
    unless items entity @s weapon.offhand * \
    run loot replace entity @s weapon.offhand loot imperium:livvy/feather

scoreboard players operation @s im_abilityCdA = #Livvy im_abilityCdA
