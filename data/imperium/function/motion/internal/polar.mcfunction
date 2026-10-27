# Player looking exactly straight up (x_rotation -90): the impulse's local frame disagrees with
# execute's ^ frame there, so remap the local vector. Ported from player_motion's
# internal/launch/handle_polar/global. Only x and y are affected; a pure-forward vector is fine.
execute if score #lx im.motion matches 0 if score #ly im.motion matches 0 run return 0

scoreboard players operation #ly im.motion >< #lz im.motion

# Yaw within 90..-90 (the wrapped range, i.e. facing north-ish): flip x. Otherwise flip y.
execute if entity @s[y_rotation=90..-90] run return run scoreboard players operation #lx im.motion *= #-1 im.motion
scoreboard players operation #ly im.motion *= #-1 im.motion
