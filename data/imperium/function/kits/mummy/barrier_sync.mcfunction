# Hold sync: mirror the live absorption hearts back into the energy meter so it drains as the barrier
#   soaks hits. energy = AbsorptionAmount * 100 / Scale  (inverse of barrier_raise's projection).
execute store result score #abs100 im.temp run data get entity @s AbsorptionAmount 100
scoreboard players operation #abs100 im.temp /= #MummyBarrierScale im.param
scoreboard players operation @s im_energy = #abs100 im.temp