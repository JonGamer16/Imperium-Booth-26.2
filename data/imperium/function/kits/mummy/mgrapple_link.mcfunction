# Run as a freshly-spawned fishing bobber, at the bobber. Bobbers spawn on top of the caster, so if
# a grapple-rod Mummy is right here, link the two with a shared id (im_grappleId) — that id is how
# per-tick tracking and the reel find the correct Mummy (and her hooked target) even with several
# Mummies casting. Then boost the bobber's cast speed so it shoots out faster.
execute unless entity @p[tag=im.mgrapple_user,distance=..5] run return 0

scoreboard players add #next im_grappleId 1
scoreboard players operation @s im_grappleId = #next im_grappleId
tag @s add im.mgrapple_bobber
execute as @p[tag=im.mgrapple_user,distance=..5] run scoreboard players operation @s im_grappleId = #next im_grappleId

# Faster cast: scale the bobber's launch Motion by #MummyCastSpeed (integer multiplier). Read each
# axis (x10000), multiply, write back (the double scale 0.0001 undoes the x10000).
execute store result score #cx im_grappleX run data get entity @s Motion[0] 10000
execute store result score #cy im_grappleY run data get entity @s Motion[1] 10000
execute store result score #cz im_grappleZ run data get entity @s Motion[2] 10000
scoreboard players operation #cx im_grappleX *= #MummyCastSpeed im.param
scoreboard players operation #cy im_grappleY *= #MummyCastSpeed im.param
scoreboard players operation #cz im_grappleZ *= #MummyCastSpeed im.param
execute store result entity @s Motion[0] double 0.0001 run scoreboard players get #cx im_grappleX
execute store result entity @s Motion[1] double 0.0001 run scoreboard players get #cy im_grappleY
execute store result entity @s Motion[2] double 0.0001 run scoreboard players get #cz im_grappleZ
