# TEMPORARY probe for the cooldown_dealt bug: same as probe_husk but with the namespaced key "minecraft:entity_type".
advancement revoke @s only imperium:test/probe_husk_ns
tellraw @s {text:"[probe] hit target is minecraft:husk (namespaced key)",color:"light_purple"}
