# AV cue for landing a charged Strike — reward of imperium:rastus_strike_cue, which earns when
# a player tagged im.rastus_focused (Strike armed) damages an entity. Runs as/at the attacker.
# Re-arm immediately so the next Strike fires it again.
advancement revoke @s only imperium:rastus_strike_cue

# playsound minecraft:item.trident.thunder player @s ~ ~ ~ 0.8 1.3
# particle minecraft:electric_spark ~ ~1 ~0.6 0.4 0.4 0.4 0.25 24
# particle minecraft:crit            ~ ~1 ~0.6 0.4 0.4 0.4 0.30 14

execute \
    at @s \
    run playsound entity.blaze.hurt player @a ~ ~ ~ 0.8 1.5
execute \
    at @s \
    run playsound block.amethyst_block.place player @a ~ ~ ~ 1 1