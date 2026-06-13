# Runs once, as a freshly-thrown Smoke Bomb cloud, at its position
tag @s add im.smoke_bomb

# 10s duration, constant 3-block radius, no shrink on use or over time
data merge entity @s {Duration:200,Radius:3.0f,RadiusOnUse:0.0f,RadiusPerTick:0.0f,WaitTime:0}

# One thick puff of signal smoke
particle minecraft:campfire_signal_smoke ~ ~1 ~ 1.5 0.6 1.5 0.002 700 normal @a
