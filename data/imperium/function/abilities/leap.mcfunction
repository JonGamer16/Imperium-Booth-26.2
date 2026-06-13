# Leap Feather: shared looking-direction dash.
# Triggered by consuming any item flagged {im_leap_feather:1b}.
advancement revoke @s only imperium:use_leap_feather

#   Ground-Only Gate
#       Toggle the jump-leap distance technique per player via the im.leap_ground_only tag.
#       No tag  -> free leap (jump first for extra distance).
#       Tagged  -> airborne leaps refund the feather and abort, so only grounded leaps fire.
#       OnGround flips false the instant you jump, which is exactly what blocks the technique.

# execute \
#     if entity @s[tag=im.leap_ground_only] \
#     unless entity @s[nbt={OnGround:1b}] \
#     run return run function imperium:abilities/leap_refund

#   Directional Vector
#       Impulse in the player's looking direction, added on top of running momentum.
#       Strength is score x 0.0001 blocks/tick. Grounded and airborne are tuned apart so
#       the jump-leap technique can be balanced (airborne already carries jump momentum).
#       >> TUNING KNOBS: grounded / airborne strength. <<
execute unless predicate imperium:on_ground run \
    scoreboard players set $strength player_motion.api.launch 12000
#       On Ground Conditional
execute if predicate imperium:on_ground run \
    scoreboard players set $strength player_motion.api.launch 15000

function player_motion:api/launch_looking

#   Vertical Dampening
#       Keep a fraction (numerator/10) of the look-driven y. Grounded keeps more since it
#       has no jump velocity; airborne keeps less because the jump already supplied lift.
#       Numerator may be 2, 3, 4, or 5; the /10 divide is shared.
#       >> TUNING KNOBS: grounded / airborne numerator. <<
execute if predicate imperium:on_ground run \
    scoreboard players operation \
    @s player_motion.internal.motion.y \
    *= #constant.3 player_motion.internal.const
scoreboard players operation \
    @s player_motion.internal.motion.y \
    /= #constant.10 player_motion.internal.const      
#       On Ground Conditional
execute unless predicate imperium:on_ground run \
    scoreboard players operation \
    @s player_motion.internal.motion.y \
    *= #constant.2 player_motion.internal.const

#   Constant Vector
#       Flat upward floor (0.0001 b/t units). Grounded gets a real pop; airborne gets
#       little, since the jump already carries you up -- this is what tames the difference.
#       >> TUNING KNOBS: grounded / airborne baseline. <<
execute unless predicate imperium:on_ground run \
    scoreboard players add @s player_motion.internal.motion.y 4000
#       On Ground Conditional
execute if predicate imperium:on_ground run \
    scoreboard players add @s player_motion.internal.motion.y 6000


# Livvy: 1 second of Strength riding the leap
effect give @s[tag=im.kit_livvy] minecraft:strength 1 0
