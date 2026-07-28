# Personal chat feedback on kill gold. Runs as @s each second while im.fighting. Announces +3 gold
# per new kill (im_matchKills increase since last check). #kbonus im.temp holds the delta, then delta*3.
scoreboard players operation #kbonus im.temp = @s im_matchKills
scoreboard players operation #kbonus im.temp -= @s im_killsSeen
execute if score #kbonus im.temp matches 1.. run scoreboard players operation @s im_killsSeen += #kbonus im.temp
execute if score #kbonus im.temp matches 1.. run scoreboard players operation #kbonus im.temp *= #3 imperium.const
execute if score #kbonus im.temp matches 1.. run tellraw @s [{"text":"[Kill Score] +","color":"gold"},{"score":{"name":"#kbonus","objective":"im.temp"},"color":"gold"},{"text":" Gold","color":"gold"}]
