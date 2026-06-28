# Reversal step 1 — context: @s = attacker, positioned at the attacker's feet, rotated to the
# attacker's yaw with a flat pitch. Tests the nearest spot directly behind (-0.5). A spot is
# clear only if both the feet and head blocks are #minecraft:replaceable. If this one is
# blocked the whole warp aborts; if it is clear we place the blocker here, then try one deeper.

execute positioned ^ ^ ^-0.5 unless block ~ ~ ~ #minecraft:replaceable run return fail
execute positioned ^ ^ ^-0.5 unless block ~ ~1 ~ #minecraft:replaceable run return fail

execute positioned ^ ^ ^-0.5 \
    run tp @n[tag=im.reversal_target] ~ ~ ~ facing entity @s feet
# Mark that a warp landed (step 1 is required for any landing) so the cost is paid back home.
tag @n[tag=im.reversal_target] add im.reversal_done
execute positioned ^ ^ ^-0.5 run function imperium:enchantments/reversal_step2
