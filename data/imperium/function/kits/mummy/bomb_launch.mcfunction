# Vertical pop for an entity caught in the Crystal Bomb blast (runs as the target). Mirrors
# golem_launch: players go through imperium:motion (they ignore raw Motion NBT, and the
# lib is player-only — non-players return-fail); everything else, mannequins included, gets Motion
# directly — clear OnGround first so a grounded target still gets the upward pop.
scoreboard players set $x im.motion 0
scoreboard players operation $y im.motion = #BombLaunch im.param
scoreboard players set $z im.motion 0

execute if entity @s[type=player] run function imperium:motion/launch_xyz

execute unless entity @s[type=player] run data merge entity @s {OnGround:0b}
execute unless entity @s[type=player] store result entity @s Motion[1] double 0.0001 run scoreboard players get $y im.motion
