# TEMPORARY probe for the cooldown_dealt bug: player_hurt_entity with no conditions.
advancement revoke @s only imperium:test/probe_any
tellraw @s {text:"[probe] player_hurt_entity fired (no conditions)",color:"light_purple"}
