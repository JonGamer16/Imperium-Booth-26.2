# Derive @s's Gold Rush score: 1 gold per 25 damage dealt + 3 gold per kill.
# im_statDealt is in tenths of HP, so 25 HP = 250 tenths (floor keeps the remainder banked in
# the stat for the next threshold). Pure function of the round stats — safe to recompute any time.
scoreboard players operation @s im_gold = @s im_statDealt
scoreboard players operation @s im_gold /= #250 imperium.const
scoreboard players operation #kills im.temp = @s im_matchKills
scoreboard players operation #kills im.temp *= #3 imperium.const
scoreboard players operation @s im_gold += #kills im.temp
# Subtract gold forfeited to deaths (a permanent offset — future gold still accrues on top).
scoreboard players operation @s im_gold -= @s im_goldLost
