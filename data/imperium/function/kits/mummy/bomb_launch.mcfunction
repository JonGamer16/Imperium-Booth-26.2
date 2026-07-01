# Vertical pop for an entity caught in the Crystal Bomb blast (runs as the target). Mirrors
# golem_launch: players/mannequins go through the motion lib (they ignore raw Motion NBT); every other
# mob honors Motion directly — clear OnGround first so a grounded mob still gets the upward pop.
scoreboard players set $x player_motion.api.launch 0
scoreboard players operation $y player_motion.api.launch = #BombLaunch im.param
scoreboard players set $z player_motion.api.launch 0

execute if entity @s[type=#imperium:human] run function player_motion:api/launch_xyz

execute unless entity @s[type=#imperium:human] run data merge entity @s {OnGround:0b}
execute unless entity @s[type=#imperium:human] store result entity @s Motion[1] double 0.0001 run scoreboard players get $y player_motion.api.launch
