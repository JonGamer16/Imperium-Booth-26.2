clear @s shield[custom_data~{imperium_kit:1b}]

execute if items entity @s weapon.offhand * run loot give @s loot imperium:cliffshield/shield

execute unless items entity @s weapon.offhand * run loot replace entity @s weapon.offhand loot imperium:cliffshield/shield

scoreboard players operation @s im_abilityCdA += #Cliffshield im_abilityCdA
