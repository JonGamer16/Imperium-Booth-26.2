# Manual diagnostic: /function imperium:motion/debug
# Launches you 2 b/t straight up through launch_xyz and reports each stage. Not called by anything.
scoreboard players set #ret im.motion -99
scoreboard players set $x im.motion 0
scoreboard players set $y im.motion 20000
scoreboard players set $z im.motion 0
execute store result score #ret im.motion run function imperium:motion/launch_xyz

# ret: 1 = launched, 0 = zero vector, -99/0 with no saddle line = refused or apply failed to load.
# Looking roughly level, local y ~ 19860, so expect y.14=1, y.15=0, y.16=0, y.17=0 (sign).
tellraw @s [{"text":"[motion] ret=","color":"gray"},{"score":{"name":"#ret","objective":"im.motion"}},\
    " basis j.y=",{"score":{"name":"#jy","objective":"im.motion"}}," k.y=",{"score":{"name":"#ky","objective":"im.motion"}},\
    " y.14=",{"score":{"name":"#y.14","objective":"im.motion"}}," y.15=",{"score":{"name":"#y.15","objective":"im.motion"}},\
    " y.16=",{"score":{"name":"#y.16","objective":"im.motion"}}," y.17=",{"score":{"name":"#y.17","objective":"im.motion"}}]

# The saddle is removed by the enchantment's first effect, so it is the proof that location_changed fired.
execute if items entity @s saddle * run tellraw @s {"text":"[motion] saddle still equipped: location_changed did NOT fire","color":"red"}
execute unless items entity @s saddle * run tellraw @s {"text":"[motion] saddle gone: enchantment fired (or was never equipped)","color":"green"}
