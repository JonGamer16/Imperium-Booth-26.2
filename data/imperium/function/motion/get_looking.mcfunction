# Set $x / $y / $z im.motion to $strength im.motion along the EXECUTION rotation (not necessarily
# the player's view — callers can `rotated ~45 0` first, as rastus/dodge_launch does). Launches
# nothing; follow with motion/launch_xyz, or adjust the vector first (abilities/leap) or hand it
# to a projectile's Motion (smokey/use_dart). Units: 1/10000 blocks/tick.

execute positioned as @s summon minecraft:marker run function imperium:motion/internal/forward

# #k* is a unit vector x1000.
scoreboard players operation $x im.motion = #kx im.motion
scoreboard players operation $x im.motion *= $strength im.motion
scoreboard players operation $x im.motion /= #1000 im.motion
scoreboard players operation $y im.motion = #ky im.motion
scoreboard players operation $y im.motion *= $strength im.motion
scoreboard players operation $y im.motion /= #1000 im.motion
scoreboard players operation $z im.motion = #kz im.motion
scoreboard players operation $z im.motion *= $strength im.motion
scoreboard players operation $z im.motion /= #1000 im.motion
