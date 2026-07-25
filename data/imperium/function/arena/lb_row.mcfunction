# Print the highest-gold player left in im.lb_pool, then recurse until the pool is empty. Each
# lb_print removes its player(s) from the pool, so the pool shrinks every pass and this terminates.
execute unless entity @a[tag=im.lb_pool] run return 0

# Highest gold still in the pool (start below any real score).
scoreboard players set #top im.temp -2147483648
execute as @a[tag=im.lb_pool] run scoreboard players operation #top im.temp > @s im_gold

# Print + drain whoever holds that gold (ties share the pass; each gets its own row/rank), then recurse.
execute as @a[tag=im.lb_pool] if score @s im_gold = #top im.temp run function imperium:arena/lb_print
function imperium:arena/lb_row
