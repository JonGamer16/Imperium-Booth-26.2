# Clear all kit tags before assigning the new one
execute if score @s givekit matches 1.. run tag @s remove im.kit_cliffshield
execute if score @s givekit matches 1.. run tag @s remove im.kit_meowdy
execute if score @s givekit matches 1.. run tag @s remove im.kit_livvy
execute if score @s givekit matches 1.. run tag @s remove im.kit_mummy
execute if score @s givekit matches 1.. run tag @s remove im.kit_levent
execute if score @s givekit matches 1.. run tag @s remove im.kit_rastus
execute if score @s givekit matches 1.. run tag @s remove im.kit_smokey

# Initialize ability cooldowns so kit_dispatch doesn't fire until damage accumulates
execute if score @s givekit matches 1.. run scoreboard players set @s im_abilityCdA 100
execute if score @s givekit matches 1.. run scoreboard players set @s im_abilityCdB 100
execute if score @s givekit matches 1.. run scoreboard players set @s im_abilityCdC 100

# Assign kit tag and give kit items
execute if score @s givekit matches 1 run tag @s add im.kit_cliffshield
execute if score @s givekit matches 1 run function imperium:kits/cliffshield/givekit

execute if score @s givekit matches 2 run tag @s add im.kit_meowdy
execute if score @s givekit matches 2 run function imperium:kits/meowdy/givekit

execute if score @s givekit matches 3 run tag @s add im.kit_livvy
execute if score @s givekit matches 3 run function imperium:kits/livvy/givekit

execute if score @s givekit matches 4 run tag @s add im.kit_mummy
execute if score @s givekit matches 4 run function imperium:kits/mummy/givekit

execute if score @s givekit matches 5 run tag @s add im.kit_levent
execute if score @s givekit matches 5 run function imperium:kits/levent/givekit

execute if score @s givekit matches 6 run tag @s add im.kit_rastus
execute if score @s givekit matches 6 run function imperium:kits/rastus/givekit

execute if score @s givekit matches 7 run tag @s add im.kit_smokey
execute if score @s givekit matches 7 run function imperium:kits/smokey/givekit

scoreboard players operation @s im_lastKit = @s givekit
execute if score @s givekit matches 1.. run scoreboard players reset @s givekit

# givekit score of 0 is reserved for giving the last kit the player used.
# if player has a stored lastKit greater than 0, set givekit equal to lastKit and rerun.
# it shouldn't run again because lastKit and givekit are now equal and therefore false.
# 0 should be different from having a null reset score. if it's bugged, make it use 1000.
execute as @s[scores={givekit=0}] \
  if score @s im_lastKit > @s givekit \
  run function imperium:arena/lastkit
