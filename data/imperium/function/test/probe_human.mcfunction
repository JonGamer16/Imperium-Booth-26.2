# TEMPORARY probe for the cooldown_dealt bug: player_hurt_entity with only the #imperium:human entity condition.
advancement revoke @s only imperium:test/probe_human
tellraw @s {text:"[probe] player_hurt_entity fired (entity is #imperium:human)",color:"light_purple"}
