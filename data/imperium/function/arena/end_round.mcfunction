# End @s's combat round: compute final score, show the post-game summary, stop tracking.
# Reusable by the Summit booth_inactive / player_leave hooks.
tag @s remove im.fighting
tag @s remove summit.no_regen
function imperium:arena/calc_gold

# Crosshair tracker (Rastus/Levent): the leaver's interaction has no owner to follow — kill it.
function imperium:enchantments/aim_free

# Split each tenths-of-HP total into whole HP (#?W) and remaining tenths (#?F) for display.
# Distinct fake-player names share the one im.temp scratch objective, so all stats resolve in one tellraw.
scoreboard players operation #dW im.temp = @s im_statDealt
scoreboard players operation #dW im.temp /= #10 imperium.const
scoreboard players operation #dF im.temp = @s im_statDealt
scoreboard players operation #dF im.temp %= #10 imperium.const
scoreboard players operation #tW im.temp = @s im_statTaken
scoreboard players operation #tW im.temp /= #10 imperium.const
scoreboard players operation #tF im.temp = @s im_statTaken
scoreboard players operation #tF im.temp %= #10 imperium.const
scoreboard players operation #hW im.temp = @s im_statHealed
scoreboard players operation #hW im.temp /= #10 imperium.const
scoreboard players operation #hF im.temp = @s im_statHealed
scoreboard players operation #hF im.temp %= #10 imperium.const

tellraw @s [{"text":"── Round Stats ──\n","color":"gold"},{"text":"Gold: ","color":"gray"},{"score":{"name":"@s","objective":"im_gold"},"color":"gold"},{"text":"\nKills: ","color":"gray"},{"score":{"name":"@s","objective":"im_matchKills"},"color":"white"},{"text":"\nDamage dealt: ","color":"gray"},{"score":{"name":"#dW","objective":"im.temp"},"color":"white"},{"text":".","color":"white"},{"score":{"name":"#dF","objective":"im.temp"},"color":"white"},{"text":" HP","color":"gray"},{"text":"\nDamage taken: ","color":"gray"},{"score":{"name":"#tW","objective":"im.temp"},"color":"white"},{"text":".","color":"white"},{"score":{"name":"#tF","objective":"im.temp"},"color":"white"},{"text":" HP","color":"gray"},{"text":"\nDamage healed: ","color":"gray"},{"score":{"name":"#hW","objective":"im.temp"},"color":"white"},{"text":".","color":"white"},{"score":{"name":"#hF","objective":"im.temp"},"color":"white"},{"text":" HP","color":"gray"}]
