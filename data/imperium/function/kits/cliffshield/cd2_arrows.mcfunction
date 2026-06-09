clear @s arrow[custom_data={imperium_kit:1b}]

execute if items entity @s hotbar.8 * run loot give @s loot imperium:cliffshield/arrows

execute unless items entity @s hotbar.8 * run loot replace entity @s hotbar.8 loot imperium:cliffshield/arrows

scoreboard players operation @s im_abilityCdB = #Cliffshield im_abilityCdB
