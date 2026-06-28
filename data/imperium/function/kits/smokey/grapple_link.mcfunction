# Run as a freshly-spawned fishing bobber, at the bobber. Bobbers spawn on top of the caster, so
# if a grapple-rod Smokey is right here, link the two with a shared id (im_grappleId) — that id is
# how per-tick tracking and the launch find the correct player even with several Smokeys casting.
execute unless entity @p[tag=im.grapple_user,distance=..5] run return 0

scoreboard players add #next im_grappleId 1
scoreboard players operation @s im_grappleId = #next im_grappleId
tag @s add im.grapple_bobber
execute as @p[tag=im.grapple_user,distance=..5] run scoreboard players operation @s im_grappleId = #next im_grappleId
