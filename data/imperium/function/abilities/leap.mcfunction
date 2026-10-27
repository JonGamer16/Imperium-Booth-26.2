# Leap Feather: shared looking-direction dash.
# Triggered by consuming any item flagged {im_leap_feather:1b}.
advancement revoke @s only imperium:use_leap_feather

#   Directional Vector
#       Impulse in the player's looking direction, added on top of running momentum.
#       Strength is score x 0.0001 blocks/tick. Grounded and airborne are tuned apart so
#       the jump-leap technique can be balanced (airborne already carries jump momentum).
#       get_looking only computes the vector; the launch happens after the y adjustments below.
#       >> TUNING KNOBS: grounded / airborne strength. <<
execute unless predicate imperium:on_ground run \
    scoreboard players set $strength im.motion 12000
#       On Ground Conditional
execute if predicate imperium:on_ground run \
    scoreboard players set $strength im.motion 15000

function imperium:motion/get_looking

#   Vertical Dampening
#       Keep a fraction (numerator/#LeapDampDiv) of the look-driven y. Grounded keeps more since
#       it has no jump velocity; airborne keeps less because the jump already supplied lift.
#       Constants live in im.param (main/ability_parameters).
#       >> TUNING KNOBS: #LeapDampGround / #LeapDampAir numerators. <<
execute if predicate imperium:on_ground run \
    scoreboard players operation \
    $y im.motion \
    *= #LeapDampGround im.param
scoreboard players operation \
    $y im.motion \
    /= #LeapDampDiv im.param
#       On Ground Conditional
execute unless predicate imperium:on_ground run \
    scoreboard players operation \
    $y im.motion \
    *= #LeapDampAir im.param

#   Constant Vector
#       Flat upward floor (0.0001 b/t units). Grounded gets a real pop; airborne gets
#       little, since the jump already carries you up -- this is what tames the difference.
#       >> TUNING KNOBS: grounded / airborne baseline. <<
execute unless predicate imperium:on_ground run \
    scoreboard players add $y im.motion 4000
#       On Ground Conditional
execute if predicate imperium:on_ground run \
    scoreboard players add $y im.motion 6000

function imperium:motion/launch_xyz

# Livvy: 1 second of Strength riding the leap
effect give @s[tag=im.kit_livvy] minecraft:strength 1 0

# Spend a charge so the cooldown begins once the feather is used. Leap is slot A for
# both leap kits (Livvy, Meowdy); update_cooldowns clamps this at >= 0.
scoreboard players remove @s im_cdUsesA 1
