# Subtract net damage dealt and taken from each ability cooldown slot
scoreboard players operation @s im_abilityCdA -= @s im_abilityDealt
scoreboard players operation @s im_abilityCdA -= @s im_abilityTaken
scoreboard players operation @s im_abilityCdB -= @s im_abilityDealt
scoreboard players operation @s im_abilityCdB -= @s im_abilityTaken
scoreboard players operation @s im_abilityCdC -= @s im_abilityDealt
scoreboard players operation @s im_abilityCdC -= @s im_abilityTaken

# Keep cooldowns non-negative
scoreboard players operation @s im_abilityCdA > const 0
scoreboard players operation @s im_abilityCdB > const 0
scoreboard players operation @s im_abilityCdC > const 0

# Reset damage inputs now that they've been consumed
scoreboard players set @s im_abilityDealt 0
scoreboard players set @s im_abilityTaken 0

# Dispatch kit abilities for any cooldown that has expired
execute if score @s im_abilityCdA matches 0 run function imperium:kit_dispatch
execute if score @s im_abilityCdB matches 0 run function imperium:kit_dispatch
execute if score @s im_abilityCdC matches 0 run function imperium:kit_dispatch
