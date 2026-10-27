# Clamp the yank velocity to +/- #MummyGrappleMax per axis (mirror of Smokey's grapple_clamp, but on
# the Mummy's own cap). Per-axis (no sqrt), applied before the static vertical pop is added.
scoreboard players set #negmax im.param 0
scoreboard players operation #negmax im.param -= #MummyGrappleMax im.param

scoreboard players operation $x im.motion < #MummyGrappleMax im.param
scoreboard players operation $x im.motion > #negmax im.param
scoreboard players operation $y im.motion < #MummyGrappleMax im.param
scoreboard players operation $y im.motion > #negmax im.param
scoreboard players operation $z im.motion < #MummyGrappleMax im.param
scoreboard players operation $z im.motion > #negmax im.param
