# Run as the hooked entity (#mx/#my/#mz = the Mummy's position x10000, set in mgrapple_launch).
# Pull toward the Mummy: velocity (1/10000 b/t) = (mummy - me) / divisor, x/z by #MummyGrappleLateral,
# y by #MummyGrappleVertPull, capped at +/- #MummyGrappleMax per axis, plus the flat #MummyGrappleVertical pop.
execute store result score #ex im_grappleX run data get entity @s Pos[0] 10000
execute store result score #ey im_grappleY run data get entity @s Pos[1] 10000
execute store result score #ez im_grappleZ run data get entity @s Pos[2] 10000

scoreboard players operation $x im.motion = #mx im_grappleX
scoreboard players operation $x im.motion -= #ex im_grappleX
scoreboard players operation $x im.motion /= #MummyGrappleLateral im.param
scoreboard players operation $y im.motion = #my im_grappleY
scoreboard players operation $y im.motion -= #ey im_grappleY
scoreboard players operation $y im.motion /= #MummyGrappleVertPull im.param
scoreboard players operation $z im.motion = #mz im_grappleZ
scoreboard players operation $z im.motion -= #ez im_grappleZ
scoreboard players operation $z im.motion /= #MummyGrappleLateral im.param

execute unless score #MummyGrappleMax im.param matches -1 run function imperium:kits/mummy/mgrapple_clamp

scoreboard players operation $y im.motion += #MummyGrappleVertical im.param

# Done with the hook regardless of which launch path runs, so untag before the early-return below.
tag @s remove im.mgrapple_hooked

# Players ignore raw Motion NBT, so use imperium:motion (player-only; the raw Motion
# lines below silently no-op on players since /data can't modify them).
execute if entity @s[type=player] run function imperium:motion/launch_xyz

# Any other entity (mannequins included) honors Motion directly. Clear OnGround first: a grounded
# mob keeps horizontal Motion but the ground contact swallows the upward component, so it has to be
# treated as airborne for the vertical pop to land. (The 0.0001 scale converts 1/10000-b/t to b/t.)
data merge entity @s {OnGround:0b}
execute store result entity @s Motion[0] double 0.0001 run scoreboard players get $x im.motion
execute store result entity @s Motion[1] double 0.0001 run scoreboard players get $y im.motion
execute store result entity @s Motion[2] double 0.0001 run scoreboard players get $z im.motion
