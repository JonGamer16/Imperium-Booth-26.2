# Bank any health regained since last tick into im_statHealed (tenths of HP). Runs per tick for
# im.fighting players — no vanilla "healed" criterion exists, so we sample. im.temp2 holds the
# delta momentarily; recompute im_hpSample fresh afterward as the next baseline.
execute store result score @s im.temp2 run data get entity @s Health 10
scoreboard players operation @s im.temp2 -= @s im_hpSample
execute if score @s im.temp2 matches 1.. run scoreboard players operation @s im_statHealed += @s im.temp2
execute store result score @s im_hpSample run data get entity @s Health 10
