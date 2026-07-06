# Angle check for the mob nearest this sphere center (called at the positioned point from the sweep
# in backstab.mcfunction, so the nearest mob here IS the one the sphere just detected). If the
# attacker faces roughly the same way as the target (within a 120-degree cone) they're behind it ->
# arm the backstab; otherwise mark a wrong-angle hit.
execute store result score @s im_rotationdiff run data get entity @e[type=!player,type=!#minecraft:im.not_mob,limit=1,sort=nearest] Rotation[0] 1

# Attacker yaw - target yaw.
scoreboard players operation @s im_rotation -= @s im_rotationdiff

# 120-degree backstab cone (with the +-360 wraparound).
execute if score @s im_rotation matches -60..60 run scoreboard players set @s im_backstabflag 1
execute if score @s im_rotation matches ..-300 run scoreboard players set @s im_backstabflag 1
execute if score @s im_rotation matches 300.. run scoreboard players set @s im_backstabflag 1

# Found a target but the angle was wrong.
execute if score @s im_backstabflag matches 0 run scoreboard players set @s im_backstabflag 2
