# Clamp the grapple pull velocity to +/- #GrappleMax per axis. Called from grapple_launch only when
# GrappleMax isn't -1 (unlimited). Per-axis cap (no sqrt), applied to the distance-proportional
# pull before the static vertical pop is added.
scoreboard players set #negmax im.param 0
scoreboard players operation #negmax im.param -= #GrappleMax im.param

scoreboard players operation $x player_motion.api.launch < #GrappleMax im.param
scoreboard players operation $x player_motion.api.launch > #negmax im.param
scoreboard players operation $y player_motion.api.launch < #GrappleMax im.param
scoreboard players operation $y player_motion.api.launch > #negmax im.param
scoreboard players operation $z player_motion.api.launch < #GrappleMax im.param
scoreboard players operation $z player_motion.api.launch > #negmax im.param
