# Backstab arming — a cheap sphere sweep along the look vector, replacing the old 15-step recursive
# raycast. A sphere is coarser than a ray but covers the short melee line we need; backstab_calc
# still does the 120-degree angle check. Runs every tick via backstab_context, so it (a) throttles
# to every other tick and (b) early-outs when nobody's near.

# Throttle: arming only needs to refresh a few times a second. Recompute on every other tick and
# hold the flag in between (positions barely move in 0.1s). im_backstabtracking is the counter.
scoreboard players add @s im_backstabtracking 1
execute if score @s im_backstabtracking matches 2.. run scoreboard players set @s im_backstabtracking 0
execute unless score @s im_backstabtracking matches 0 run return 0

# Clear last recompute's result (so a stale "armed" never lingers).
scoreboard players set @s im_backstabflag 0

# Cheap early-out: no mob anywhere near -> skip the yaw read and the whole sweep.
execute unless entity @e[type=!player,type=!#minecraft:im.not_mob,distance=..5,limit=1] run return 0

# Attacker yaw (compared against the target's yaw in backstab_calc).
execute store result score @s im_rotation run data get entity @s Rotation[0] 1

# Sphere sweep in front of the eyes, near segment first; stop once a mob is found (flag != 0). No
# `sort` here — existence is all we need; backstab_calc picks the nearest at the hit point. Collapse
# to one r=1.5 sphere at ^ ^ ^1.5 for the cheapest/coarsest version.
execute if score @s im_backstabflag matches 0 at @s anchored eyes positioned ^ ^ ^1.0 if entity @e[type=!player,type=!#minecraft:im.not_mob,distance=..1.0,limit=1] run function imperium:enchantments/backstab_calc
execute if score @s im_backstabflag matches 0 at @s anchored eyes positioned ^ ^ ^2.0 if entity @e[type=!player,type=!#minecraft:im.not_mob,distance=..1.0,limit=1] run function imperium:enchantments/backstab_calc
execute if score @s im_backstabflag matches 0 at @s anchored eyes positioned ^ ^ ^3.0 if entity @e[type=!player,type=!#minecraft:im.not_mob,distance=..1.0,limit=1] run function imperium:enchantments/backstab_calc
