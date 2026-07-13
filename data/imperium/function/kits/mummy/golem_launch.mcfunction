# Golem Throw launch — runs as the VICTIM (wip_golem_throw post_attack, affected=victim, gated on the
# attacker being armed). Fling the victim straight up by #GolemLaunch (1/10000 b/t). Mirrors the
# player/mob split from mgrapple_yank: players ignore raw Motion (use the summit-core motion lib,
# which is player-only); every other entity — mannequins included — gets Motion NBT directly.
scoreboard players set $x player_motion.api.launch 0
scoreboard players operation $y player_motion.api.launch = #GolemLaunch im.param
scoreboard players set $z player_motion.api.launch 0

execute if entity @s[type=player] run function player_motion:api/launch_xyz

execute unless entity @s[type=player] run data merge entity @s {OnGround:0b}
execute unless entity @s[type=player] store result entity @s Motion[1] double 0.0001 run scoreboard players get $y player_motion.api.launch

playsound minecraft:entity.iron_golem.repair player @a[distance=..32] ~ ~ ~ 1 0.7

# Recoil combo: if this victim is currently hooked by a Mummy's grapple, fling that Mummy skyward too
# ("throw them and ride the recoil"). The victim and its grappler share im_grappleId (mgrapple_link/hook).
execute if entity @s[tag=im.mgrapple_hooked] run function imperium:kits/mummy/golem_hook_recoil
