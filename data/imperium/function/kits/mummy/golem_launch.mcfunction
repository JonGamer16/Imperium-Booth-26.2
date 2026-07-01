# Golem Throw launch — runs as the VICTIM (wip_golem_throw post_attack, affected=victim, gated on the
# attacker being armed). Fling the victim straight up by #GolemLaunch (1/10000 b/t). Mirrors the
# human/mob split from mgrapple_yank: players/mannequins ignore raw Motion (use the motion lib),
# every other mob honors Motion NBT directly.
scoreboard players set $x player_motion.api.launch 0
scoreboard players operation $y player_motion.api.launch = #GolemLaunch im.param
scoreboard players set $z player_motion.api.launch 0

execute if entity @s[type=#imperium:human] run function player_motion:api/launch_xyz

execute unless entity @s[type=#imperium:human] run data merge entity @s {OnGround:0b}
execute unless entity @s[type=#imperium:human] store result entity @s Motion[1] double 0.0001 run scoreboard players get $y player_motion.api.launch

playsound minecraft:entity.iron_golem.repair player @a[distance=..32] ~ ~ ~ 1 0.7
