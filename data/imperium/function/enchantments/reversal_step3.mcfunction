# Reversal step 3 — context inherited from step 2: positioned at the -1.5 spot, still in the
# attacker's frame. Tests the farthest spot (-2.5 total). If it's blocked the blocker stays
# where step 2 put them; if it's clear this is the final, farthest landing.

execute positioned ^ ^ ^-1.0 unless block ~ ~ ~ #minecraft:replaceable run return fail
execute positioned ^ ^ ^-1.0 unless block ~ ~1 ~ #minecraft:replaceable run return fail

execute positioned ^ ^ ^-1.0 \
    run tp @n[tag=im.reversal_target] ~ ~ ~ facing entity @s feet
