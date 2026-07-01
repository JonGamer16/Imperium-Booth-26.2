# Clamp the yank velocity to +/- #MummyGrappleMax per axis (mirror of Smokey's grapple_clamp, but on
# the Mummy's own cap). Per-axis (no sqrt), applied before the static vertical pop is added.
scoreboard players set #negmax im.param 0
scoreboard players operation #negmax im.param -= #MummyGrappleMax im.param

scoreboard players operation $x player_motion.api.launch < #MummyGrappleMax im.param
scoreboard players operation $x player_motion.api.launch > #negmax im.param
scoreboard players operation $y player_motion.api.launch < #MummyGrappleMax im.param
scoreboard players operation $y player_motion.api.launch > #negmax im.param
scoreboard players operation $z player_motion.api.launch < #MummyGrappleMax im.param
scoreboard players operation $z player_motion.api.launch > #negmax im.param
