# TEMPORARY probe for the cooldown_dealt bug: player_hurt_entity where the target is minecraft:interaction.
advancement revoke @s only imperium:test/probe_interaction
tellraw @s {text:"[probe] hit target is minecraft:interaction",color:"light_purple"}
