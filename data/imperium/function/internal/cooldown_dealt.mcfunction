# Ability cooldown engine — dealt-damage trigger (advancement-driven; replaces the per-tick
# `@a run update_cooldowns` in imperium:loop). Fires from imperium:combat/cooldown_dealt on
# minecraft:player_hurt_entity, as the attacking player. Cooldowns only ever change via
# im_abilityDealt / im_abilityTaken, so running the engine only on damage events is exact and
# costs nothing on quiet ticks. Re-arm, then run the engine if the player is in the arena.
advancement revoke @s only imperium:combat/cooldown_dealt
execute if entity @s[tag=im.fighting] run function imperium:update_cooldowns
execute if entity @s[tag=im.fighting] run function imperium:arena/gold_dmg_bonus
