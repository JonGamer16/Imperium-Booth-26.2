clear @s fishing_rod[custom_data={imperium_kit:1b}]

execute \
    if items entity @s weapon.offhand * \
    run loot give @s loot imperium:smokey/fishing_rod

execute \
    unless items entity @s weapon.offhand * \
    run loot replace entity @s weapon.offhand loot imperium:smokey/fishing_rod

scoreboard players operation @s im_abilityCdA += #Smokey im_abilityCdA
