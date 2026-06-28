# Run as the owner, at the owner, on reel-in with an anchored bobber. Launch toward the stored
# offset (x/z by #GrappleLateral, y by #GrappleVertPull) plus a static vertical pop (#GrappleVertical), then put the rod
# on cooldown and clear it (cd1_rod re-gives it once im_abilityCdA bleeds back to 0).
tag @s remove im.grapple_armed

# Skip a trivial grapple (bobber basically on top of the player) — no meaningful pull.
execute if score @s im_grappleX matches -15000..15000 if score @s im_grappleZ matches -15000..15000 run return 0

# Velocity (1/10000 blocks/tick): x,z = offset / GrappleLateral; y = offset / GrappleVertPull. This
# distance-proportional pull is capped at +/- GrappleMax per axis (-1 = unlimited); the static
# GrappleVertical pop is added AFTER the cap so it always lands.
scoreboard players operation $x player_motion.api.launch = @s im_grappleX
scoreboard players operation $x player_motion.api.launch /= #GrappleLateral im.param
scoreboard players operation $y player_motion.api.launch = @s im_grappleY
scoreboard players operation $y player_motion.api.launch /= #GrappleVertPull im.param
scoreboard players operation $z player_motion.api.launch = @s im_grappleZ
scoreboard players operation $z player_motion.api.launch /= #GrappleLateral im.param

execute unless score #GrappleMax im.param matches -1 run function imperium:kits/smokey/grapple_clamp

scoreboard players operation $y player_motion.api.launch += #GrappleVertical im.param
function player_motion:api/launch_xyz

scoreboard players operation @s im_abilityCdA = #Smokey im_abilityCdA

playsound minecraft:block.chain.place master @a[distance=..32] ~ ~ ~ 1 1.6
