# Vertical pop for an entity caught in the Crystal Bomb blast (runs as the target). Mirrors
# golem_launch: players go through the summit-core motion lib (they ignore raw Motion NBT, and the
# lib is player-only — non-players return-fail); everything else, mannequins included, gets Motion
# directly — clear OnGround first so a grounded target still gets the upward pop.
scoreboard players set $x player_motion.api.launch 0
scoreboard players operation $y player_motion.api.launch = #BombLaunch im.param
scoreboard players set $z player_motion.api.launch 0

execute if entity @s[type=player] run function player_motion:api/launch_xyz

execute unless entity @s[type=player] run data merge entity @s {OnGround:0b}
execute unless entity @s[type=player] store result entity @s Motion[1] double 0.0001 run scoreboard players get $y player_motion.api.launch
