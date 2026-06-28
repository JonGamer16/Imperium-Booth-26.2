# Reversal step 2 — context inherited from step 1: positioned at the -0.5 spot, still in the
# attacker's frame. Tests one block deeper (-1.5 total). If it's blocked we return and the
# blocker stays where step 1 put them; if it's clear we move them back and try the last step.

execute positioned ^ ^ ^-1.0 unless block ~ ~ ~ #minecraft:replaceable run return fail
execute positioned ^ ^ ^-1.0 unless block ~ ~1 ~ #minecraft:replaceable run return fail

execute positioned ^ ^ ^-1.0 \
    run tp @n[tag=im.reversal_target] ~ ~ ~ facing entity @s feet
execute positioned ^ ^ ^-1.0 run function imperium:enchantments/reversal_step3
