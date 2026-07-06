# Golem Throw + grapple combo (runs as the hooked victim). The victim and its grappling Mummy share
# im_grappleId (see mgrapple_link/hook), so find that Mummy and fling her straight up by
# #GolemHookLaunch. The Mummy is a player, so she goes through the motion lib (launch_xyz). Reuses the
# shared $x/$y/$z launch slot — the victim's own launch already applied by the time we get here.
scoreboard players operation #vGrappleId im_grappleId = @s im_grappleId
scoreboard players set $x player_motion.api.launch 0
scoreboard players operation $y player_motion.api.launch = #GolemHookLaunch im.param
scoreboard players set $z player_motion.api.launch 0
execute as @a[tag=im.kit_mummy] if score @s im_grappleId = #vGrappleId im_grappleId run function player_motion:api/launch_xyz
