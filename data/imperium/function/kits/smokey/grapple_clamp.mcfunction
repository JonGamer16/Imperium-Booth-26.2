# Clamp the grapple pull velocity to +/- #GrappleMax per axis. Called from grapple_launch only when
# GrappleMax isn't -1 (unlimited). Per-axis cap (no sqrt), applied to the distance-proportional
# pull before the static vertical pop is added.
scoreboard players set #negmax im.param 0
scoreboard players operation #negmax im.param -= #GrappleMax im.param

scoreboard players operation $x im.motion < #GrappleMax im.param
scoreboard players operation $x im.motion > #negmax im.param
scoreboard players operation $y im.motion < #GrappleMax im.param
scoreboard players operation $y im.motion > #negmax im.param
scoreboard players operation $z im.motion < #GrappleMax im.param
scoreboard players operation $z im.motion > #negmax im.param
