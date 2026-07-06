# Derive @s's Gold Rush score: 1 gold per 25 damage dealt + 3 gold per kill.
# im_statDealt is in tenths of HP, so 25 HP = 250 tenths (floor keeps the remainder banked in
# the stat for the next threshold). Pure function of the round stats — safe to recompute any time.
scoreboard players operation @s im_gold = @s im_statDealt
scoreboard players operation @s im_gold /= const 250
scoreboard players operation #kills im.temp2 = @s im_matchKills
scoreboard players operation #kills im.temp2 *= const 3
scoreboard players operation @s im_gold += #kills im.temp2
# Subtract gold forfeited to deaths (a permanent offset — future gold still accrues on top).
scoreboard players operation @s im_gold -= @s im_goldLost
