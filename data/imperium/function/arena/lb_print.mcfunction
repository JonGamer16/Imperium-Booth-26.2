# Print one leaderboard row for @s (the next-highest-gold player) and drain them from the pool.
tag @s remove im.lb_pool
scoreboard players add #rank im.temp 1

# Damage dealt/taken are tracked in tenths of HP; show whole HP for a compact row.
scoreboard players operation #dmgD im.temp = @s im_statDealt
scoreboard players operation #dmgD im.temp /= #10 imperium.const
scoreboard players operation #dmgT im.temp = @s im_statTaken
scoreboard players operation #dmgT im.temp /= #10 imperium.const

tellraw @a[tag=im.round] [{"score":{"name":"#rank","objective":"im.temp"},"color":"gold"},{"text":". ","color":"gray"},{"selector":"@s","color":"yellow"},{"text":"  ","color":"gray"},{"score":{"name":"@s","objective":"im_gold"},"color":"gold"},{"text":" gold · ","color":"gray"},{"score":{"name":"@s","objective":"im_lives"},"color":"red"},{"text":" lives · ","color":"gray"},{"text":"dealt ","color":"dark_gray"},{"score":{"name":"#dmgD","objective":"im.temp"},"color":"gray"},{"text":" / taken ","color":"dark_gray"},{"score":{"name":"#dmgT","objective":"im.temp"},"color":"gray"},{"text":" HP","color":"dark_gray"}]

# Sticker 3: on an interval end (#earlyEnd=0) the rank-1 (top gold) player is the winner. On early
# ends lb_winner already crowned rank 1 and pulled them from the pool, so #rank starts at 2 here and
# this never double-grants.
execute if score #rank im.temp matches 1 run function imperium:arena/grant_win_sticker
