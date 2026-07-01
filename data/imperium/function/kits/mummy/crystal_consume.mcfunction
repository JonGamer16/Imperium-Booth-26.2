# Crystal consume dispatcher (per Mummy, each tick via energy_tick). A consumed Energy Crystal leaves
# a marked bowl (use_remainder in loot_table/mummy/healing). Count them without removing; bail if none.
# Then branch on the player's stance at the moment of consume, and clear the spent bowls afterward:
#   sneaking -> Crystal Bomb  (place it + reduced resource giveback) [crystal_bomb]
#   standing -> normal eat     (full energy refill)                  [crystal_eat]
execute store result score #crystals im.temp run clear @s bowl[custom_data~{imperium_energy_used:1b}] 0
execute unless score #crystals im.temp matches 1.. run return fail

execute if entity @s[predicate=imperium:sneaking] run function imperium:kits/mummy/crystal_bomb
execute unless entity @s[predicate=imperium:sneaking] run function imperium:kits/mummy/crystal_eat

clear @s bowl[custom_data~{imperium_energy_used:1b}]
