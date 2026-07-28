# Runs once, as a freshly-thrown Smoke Bomb cloud, at its position
tag @s add im.smoke_bomb
# Booth-owned (Summit rule: tag all our entities so the server / other booths can target ours exclusively).
tag @s add summit.booth_entity.imperium

# Constant 3-block radius, no shrink on use or over time; lifetime from #SmokeDuration
# (main/ability_parameters).
data merge entity @s {Radius:3.0f,RadiusOnUse:0.0f,RadiusPerTick:0.0f,WaitTime:0}
execute store result entity @s Duration int 1 run scoreboard players get #SmokeDuration im.param

# One thick puff of signal smoke
execute \
    as @a[tag=!im.kit_smokey] \
    run particle minecraft:campfire_signal_smoke ~ ~1 ~ 1.5 0.6 1.5 0.002 700 normal @s
execute \
    as @a[tag=im.kit_smokey] \
    run particle minecraft:campfire_signal_smoke ~ ~0.2 ~ 1.5 0 1.5 0.002 100 normal @s