# Refresh the standings billboard: rank the top 3 fighters by im_gold and rewrite the text. Called
# each second from loop_1s; self-guards on the board existing. Ties: limit=1 picks one arbitrarily.
# Ranking walks a shrinking pool (im.board_pool), tagging the current max as rank1 -> rank2 -> rank3.
execute unless entity @e[type=text_display,tag=im.gold_board_text] run return 0

tag @a[tag=im.rank1,limit=1] remove im.rank1
tag @a[tag=im.rank2,limit=1] remove im.rank2
tag @a[tag=im.rank3,limit=1] remove im.rank3
tag @a[tag=im.fighting] add im.board_pool

# rank 1: highest gold in the pool
scoreboard players set #top im.temp -2147483648
execute as @a[tag=im.board_pool] run scoreboard players operation #top im.temp > @s im_gold
execute as @a[tag=im.board_pool] if score @s im_gold = #top im.temp run tag @s add im.istop
tag @a[tag=im.istop,limit=1] add im.rank1
tag @a remove im.istop
tag @a[tag=im.rank1] remove im.board_pool

# rank 2
scoreboard players set #top im.temp -2147483648
execute as @a[tag=im.board_pool] run scoreboard players operation #top im.temp > @s im_gold
execute as @a[tag=im.board_pool] if score @s im_gold = #top im.temp run tag @s add im.istop
tag @a[tag=im.istop,limit=1] add im.rank2
tag @a remove im.istop
tag @a[tag=im.rank2] remove im.board_pool

# rank 3
scoreboard players set #top im.temp -2147483648
execute as @a[tag=im.board_pool] run scoreboard players operation #top im.temp > @s im_gold
execute as @a[tag=im.board_pool] if score @s im_gold = #top im.temp run tag @s add im.istop
tag @a[tag=im.istop,limit=1] add im.rank3
tag @a remove im.istop
tag @a remove im.board_pool

data modify entity @e[type=text_display,tag=im.gold_board_text,limit=1] text set value \
    [{text:"⚔ Gold Rush ⚔\n",color:"gold",bold:true},\
    {text:"1st - ",color:"yellow"},\
    {selector:"@a[tag=im.rank1,limit=1]",color:"yellow"},\
    {text:" [",color:"yellow"},\
    {score:{name:"@a[tag=im.rank1,limit=1]",objective:"im_gold"},color:"yellow"},\
    {text:" Gold]\n",color:"yellow"},\
    {text:"2nd - ",color:"gray"},\
    {selector:"@a[tag=im.rank2,limit=1]",color:"gray"},\
    {text:" [",color:"gray"},\
    {score:{name:"@a[tag=im.rank2,limit=1]",objective:"im_gold"},color:"gray"},\
    {text:" Gold]\n",color:"gray"},{text:"3rd - ",color:"gold"},\
    {selector:"@a[tag=im.rank3,limit=1]",color:"gold"},\
    {text:" [",color:"gold"},\
    {score:{name:"@a[tag=im.rank3,limit=1]",objective:"im_gold"},color:"gold"},\
    {text:" Gold]",color:"gold"}]
