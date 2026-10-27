# TEMPORARY probe for the cooldown_dealt bug: player_hurt_entity where the target is minecraft:husk.
advancement revoke @s only imperium:test/probe_husk
tellraw @s {text:"[probe] hit target is minecraft:husk",color:"light_purple"}
