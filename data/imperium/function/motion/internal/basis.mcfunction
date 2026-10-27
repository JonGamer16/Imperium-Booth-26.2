# As a fresh marker at the player, in the player's rotation. Store the local left (i), up (j) and
# forward (k) unit vectors x1000 as #i*/#j*/#k*, then remove the marker. `^` offsets resolve from
# the execution position, so each tp measures from the origin, not from the previous hop.
execute store result score #ox im.motion run data get entity @s Pos[0] 1000
execute store result score #oy im.motion run data get entity @s Pos[1] 1000
execute store result score #oz im.motion run data get entity @s Pos[2] 1000

tp @s ^1 ^ ^
execute store result score #ix im.motion run data get entity @s Pos[0] 1000
execute store result score #iz im.motion run data get entity @s Pos[2] 1000

tp @s ^ ^1 ^
execute store result score #jx im.motion run data get entity @s Pos[0] 1000
execute store result score #jy im.motion run data get entity @s Pos[1] 1000
execute store result score #jz im.motion run data get entity @s Pos[2] 1000

tp @s ^ ^ ^1
execute store result score #kx im.motion run data get entity @s Pos[0] 1000
execute store result score #ky im.motion run data get entity @s Pos[1] 1000
execute store result score #kz im.motion run data get entity @s Pos[2] 1000

kill @s

scoreboard players operation #ix im.motion -= #ox im.motion
scoreboard players operation #iz im.motion -= #oz im.motion
scoreboard players operation #jx im.motion -= #ox im.motion
scoreboard players operation #jy im.motion -= #oy im.motion
scoreboard players operation #jz im.motion -= #oz im.motion
scoreboard players operation #kx im.motion -= #ox im.motion
scoreboard players operation #ky im.motion -= #oy im.motion
scoreboard players operation #kz im.motion -= #oz im.motion
