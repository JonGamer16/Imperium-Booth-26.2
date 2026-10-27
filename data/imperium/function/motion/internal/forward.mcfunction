# As a fresh marker, in the caller's rotation. Store the forward unit vector x1000 as #k*, then
# remove the marker. The forward-only half of internal/basis.
execute store result score #ox im.motion run data get entity @s Pos[0] 1000
execute store result score #oy im.motion run data get entity @s Pos[1] 1000
execute store result score #oz im.motion run data get entity @s Pos[2] 1000

tp @s ^ ^ ^1
execute store result score #kx im.motion run data get entity @s Pos[0] 1000
execute store result score #ky im.motion run data get entity @s Pos[1] 1000
execute store result score #kz im.motion run data get entity @s Pos[2] 1000

kill @s

scoreboard players operation #kx im.motion -= #ox im.motion
scoreboard players operation #ky im.motion -= #oy im.motion
scoreboard players operation #kz im.motion -= #oz im.motion
