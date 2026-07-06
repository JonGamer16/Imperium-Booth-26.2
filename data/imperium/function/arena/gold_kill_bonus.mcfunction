# Personal chat feedback on kill gold. Runs as @s each second while im.fighting. Announces +3 gold
# per new kill (im_matchKills increase since last check). im.temp2 (@s) holds the delta, then delta*3.
scoreboard players operation @s im.temp2 = @s im_matchKills
scoreboard players operation @s im.temp2 -= @s im_killsSeen
execute if score @s im.temp2 matches 1.. run scoreboard players operation @s im_killsSeen += @s im.temp2
execute if score @s im.temp2 matches 1.. run scoreboard players operation @s im.temp2 *= const 3
execute if score @s im.temp2 matches 1.. run tellraw @s [{"text":"[Kill Score] +","color":"gold"},{"score":{"name":"@s","objective":"im.temp2"},"color":"gold"},{"text":" Gold","color":"gold"}]
