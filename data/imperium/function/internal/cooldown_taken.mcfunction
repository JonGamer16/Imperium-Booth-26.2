# Ability cooldown engine — taken-damage trigger (advancement-driven). Fires from
# imperium:combat/cooldown_taken on minecraft:entity_hurt_player, as the hurt player. Mirror of
# imperium:internal/cooldown_dealt. If both fire in one tick the engine runs twice; harmless
# (the second pass consumes the already-zeroed damage inputs). Re-arm, then run the engine.
advancement revoke @s only imperium:combat/cooldown_taken

# Same gate removal as cooldown_dealt: im.fighting blocked the booth and was redundant in the
# arena (ability_zone's battlegrounds branch already demands it). No #imperium:human restriction
# on this side — the source of the damage isn't checked, so environmental damage still charges,
# exactly as it did before. Add a damage.source_entity type gate in combat/cooldown_taken.json
# if fall/fire damage should stop feeding cooldowns.
function imperium:update_cooldowns
