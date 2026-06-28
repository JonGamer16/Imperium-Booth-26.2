# Run as the owner. Store the offset (bobber - owner) in 1/10000 blocks and arm for reel-in.
# #bx/#by/#bz hold the bobber position (x10000) set in grapple_scan this tick.
execute store result score #ox im_grappleX run data get entity @s Pos[0] 10000
execute store result score #oy im_grappleY run data get entity @s Pos[1] 10000
execute store result score #oz im_grappleZ run data get entity @s Pos[2] 10000

scoreboard players operation @s im_grappleX = #bx im_grappleX
scoreboard players operation @s im_grappleX -= #ox im_grappleX
scoreboard players operation @s im_grappleY = #by im_grappleY
scoreboard players operation @s im_grappleY -= #oy im_grappleY
scoreboard players operation @s im_grappleZ = #bz im_grappleZ
scoreboard players operation @s im_grappleZ -= #oz im_grappleZ

tag @s add im.grapple_armed
