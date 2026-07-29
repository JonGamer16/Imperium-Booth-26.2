# AV cue for landing a charged Strike — reward of imperium:rastus_strike_cue, which earns when
# a player tagged im.rastus_focused (Strike armed) damages an entity. Runs as/at the attacker.
# Re-arm immediately so the next Strike fires it again.
advancement revoke @s only imperium:rastus_strike_cue

execute \
    at @s \
    run playsound entity.blaze.hurt player @a[distance=..32] ~ ~ ~ 0.8 1.5
execute \
    at @s \
    run playsound block.amethyst_block.place player @a[distance=..32] ~ ~ ~ 1 1