# Reduce incoming knockback on the victim and apply a "light" damage instance
# This function is intended to be executed with the victim as @s (see enchantment post_attack affected=victim)
# 1. Read victim motion into the player_motion API scoreboard (stored as fixed-point *10000)
# Store victim motion into the player_motion API variables expected by `player_motion:api/launch_xyz`
execute store result score $x player_motion.api.launch run data get entity @s Motion[0] -10000
execute store result score $y player_motion.api.launch run data get entity @s Motion[1] -10000
execute store result score $z player_motion.api.launch run data get entity @s Motion[2] -10000

# 2. Reduce the motion values to lower knockback (divide by 2 -> half knockback)
scoreboard players operation $x player_motion.api.launch *= #constant.4 player_motion.internal.const
scoreboard players operation $y player_motion.api.launch *= #constant.4 player_motion.internal.const
scoreboard players operation $z player_motion.api.launch *= #constant.4 player_motion.internal.const

scoreboard players operation $x player_motion.api.launch /= #constant.5 player_motion.internal.const
scoreboard players operation $y player_motion.api.launch /= #constant.5 player_motion.internal.const
scoreboard players operation $z player_motion.api.launch /= #constant.5 player_motion.internal.const

# 3. Re-launch the victim with the reduced motion using player_motion API
function player_motion:api/launch_xyz

# 4. Also apply an explicit damage_entity call with custom damage type (optional small extra damage)
#    This demonstrates use of the custom damage type `imperium:light` which is tagged to bypass cooldowns.
#function imperium:enchantments/rapier_damage
