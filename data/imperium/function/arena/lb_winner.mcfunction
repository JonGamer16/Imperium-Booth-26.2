# Crown the early-end survivor as rank 1 (@s = the last fighter standing). Pull them from the pool
# so lb_row ranks only the rest, and seed #rank at 1 so the gold ranking continues from 2. Called
# from resolve_match only when #earlyEnd=1.
tag @s remove im.lb_pool
scoreboard players set #rank im.temp 1

# Damage dealt/taken are tracked in tenths of HP; show whole HP for a compact row.
scoreboard players operation #dmgD im.temp = @s im_statDealt
scoreboard players operation #dmgD im.temp /= const 10
scoreboard players operation #dmgT im.temp = @s im_statTaken
scoreboard players operation #dmgT im.temp /= const 10

tellraw @a[tag=im.round] [{"text":"★ WINNER — ","color":"gold","bold":true},{"selector":"@s","color":"yellow","bold":true},{"text":"  ","color":"gray"},{"score":{"name":"@s","objective":"im_gold"},"color":"gold"},{"text":" gold · ","color":"gray"},{"score":{"name":"@s","objective":"im_lives"},"color":"red"},{"text":" lives left  ","color":"gray"},{"text":"(dealt ","color":"dark_gray"},{"score":{"name":"#dmgD","objective":"im.temp"},"color":"gray"},{"text":" / taken ","color":"dark_gray"},{"score":{"name":"#dmgT","objective":"im.temp"},"color":"gray"},{"text":" HP)","color":"dark_gray"}]

# Sticker 3: this survivor is the round winner (rank 1). grant_win_sticker applies the >=5-gold gate
# on a walkover (#earlyEnd=2) and grants outright on an elimination win (#earlyEnd=1).
function imperium:arena/grant_win_sticker
