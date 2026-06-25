# Ability cooldown engine — taken-damage trigger (advancement-driven). Fires from
# imperium:combat/cooldown_taken on minecraft:entity_hurt_player, as the hurt player. Mirror of
# imperium:internal/cooldown_dealt. If both fire in one tick the engine runs twice; harmless
# (the second pass consumes the already-zeroed damage inputs). Re-arm, then run the engine.
advancement revoke @s only imperium:combat/cooldown_taken
execute if entity @s[advancements={imperium:leave_spawn=true}] run function imperium:update_cooldowns
