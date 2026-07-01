# Normal Energy Crystal eat (standing — barrier is down). Full energy refund (#crystals bowls *
# #MummyEnergyCrystal), capped at the max. The heal comes from the consumable's on_consume_effects.
# #crystals im.temp is set by the crystal_consume dispatcher before this runs.
scoreboard players operation #crystals im.temp *= #MummyEnergyCrystal im.param
scoreboard players operation @s im_energy += #crystals im.temp
execute if score @s im_energy > #MummyEnergyMax im.param run scoreboard players operation @s im_energy = #MummyEnergyMax im.param
playsound block.enchantment_table.use player @a ~ ~ ~ 1 0.7
