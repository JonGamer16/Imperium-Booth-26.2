# Summon @s's personal crosshair-tracker interaction and pair it to them via a shared id
# (im_aimId), same scheme as Mummy's crystal_bomb owner pairing: stamp the next global id on the
# player and on the just-summoned entity. Runs as the player from aim_tick's first tick.
execute at @s anchored eyes run summon interaction ^ ^-0.001 ^3 {width:1f,height:1f,Tags:["im.aim","im.aim_new"]}

scoreboard players add #next im_aimId 1
scoreboard players operation @s im_aimId = #next im_aimId
execute as @e[type=interaction,tag=im.aim_new,limit=1] run scoreboard players operation @s im_aimId = #next im_aimId
tag @e[type=interaction,tag=im.aim_new] remove im.aim_new

tag @s add im.aim_bound
say aim_bind