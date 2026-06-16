clear @s feather[custom_data={imperium_kit:1b}]

execute \
    if items entity @s weapon.offhand * \
    run loot give @s loot imperium:meowdy/feather

execute \
    unless items entity @s weapon.offhand * \
    run loot replace entity @s weapon.offhand loot imperium:meowdy/feather

scoreboard players operation @s im_abilityCdA += #Meowdy im_abilityCdA
scoreboard players operation @s im_cdUsesA = #Meowdy im_cdMaxA
scoreboard players operation @s im_cdFloorA = #Meowdy im_cdFloorA
scoreboard players operation @s im_cdMaxA = #Meowdy im_cdMaxA
