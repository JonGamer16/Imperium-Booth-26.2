# Final standings. Scores every round participant (im.round = still-fighting AND already-eliminated),
# then prints a gold-ranked leaderboard — each row shows gold, lives left, and damage dealt/taken.
# On an early end (#earlyEnd=1) the lone survivor is crowned first regardless of gold ("last to leave
# the arena"), then the rest fall in by gold; on an interval end (#earlyEnd=0) rank 1 is just the
# most gold. Shown to im.round (everyone who played this round), so the eliminated see it too.
execute as @a[tag=im.round] run function imperium:arena/calc_gold

# Nobody played -> nothing to show (also guards the local/test case).
execute unless entity @a[tag=im.round] run return 0

# im.lb_pool is the "not yet printed" set the ranking walk drains; #rank is the row counter.
tag @a[tag=im.round] add im.lb_pool
scoreboard players set #rank im.temp 0

tellraw @a[tag=im.round] [{"text":"\n── Final Standings ──","color":"gold","bold":true}]

# Early end: crown the last one standing first (pulls them out of the pool at rank 1). If a double
# knockout emptied the arena (no survivor), this matches nobody and we fall through to pure gold.
execute if score #earlyEnd im.temp matches 1 as @a[tag=im.fighting,tag=im.round] run function imperium:arena/lb_winner

# Everyone still in the pool, ranked by gold high-to-low.
function imperium:arena/lb_row

tag @a[tag=im.lb_pool] remove im.lb_pool

# TODO(Slice 3): grant the champion sticker to the rank-1 player (the survivor on an early end,
# else the top-gold fighter).
