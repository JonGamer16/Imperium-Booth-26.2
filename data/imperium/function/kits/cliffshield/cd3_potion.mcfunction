clear @s potion[custom_data~{imperium_kit:1b}]

# ALWAYS run the occupied case first; this avoids giving 2 copies of the item
execute if items entity @s hotbar.7 * run loot give @s loot imperium:cliffshield/potion

# If unoccupied, place the loot in hotbar.7 (8th slot)
execute unless items entity @s hotbar.7 * run loot replace entity @s hotbar.7 loot imperium:cliffshield/potion

scoreboard players operation @s im_abilityCdC += #Cliffshield im_abilityCdC
