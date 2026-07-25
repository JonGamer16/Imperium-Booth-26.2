# Gold Rush death penalty for @s: forfeit half your current gold, and spend one life. Reusable by
# the Summit player_died hook. Banks the loss into im_goldLost (a permanent offset calc_gold
# subtracts), so future gold still accrues normally afterward. im.temp2 (@s) briefly holds the
# amount lost. When im_lives hits 0 the fighter is eliminated (arena/eliminate).
scoreboard players set @s im_deaths 0
function imperium:arena/calc_gold

# Crosshair tracker (Rastus/Levent): kill the dead player's interaction; aim_tick re-summons a
# fresh one once they're back holding the enchanted weapon.
function imperium:enchantments/aim_free

# lost = floor(current gold / 2); add it to the running deduction, then recompute.
scoreboard players operation @s im.temp2 = @s im_gold
scoreboard players operation @s im.temp2 /= const 2
scoreboard players operation @s im_goldLost += @s im.temp2
function imperium:arena/calc_gold

# This death spends a life.
scoreboard players remove @s im_lives 1

# Kill feed: if a recent fighter dealt the killing blow, broadcast it as that killer. Stash the
# forfeited amount (#lost) + the recorded attacker id (#atk) before switching context to the killer.
scoreboard players operation #lost im.temp = @s im.temp2
scoreboard players operation #atk im.temp = @s im_lastAtkId
tag @s add im.feed_victim
execute if score @s im_lastAtkTime matches 1.. as @a[tag=im.fighting] if score @s im_combatId = #atk im.temp run function imperium:arena/kill_feed
tag @s remove im.feed_victim
scoreboard players set @s im_lastAtkId 0
scoreboard players set @s im_lastAtkTime 0

# Personal death notice with the lives left. At 0, hand off to elimination instead.
execute if score @s im_lives matches 1..2 run tellraw @s [{"text":" -","color":"red"},{"score":{"name":"@s","objective":"im.temp2"},"color":"gold"},{"text":" gold","color":"red"},{"text":" | Lives remaining: ","color":"red"},{"score":{"name":"@s","objective":"im_lives"},"color":"yellow"}]
execute if score @s im_lives matches ..0 run function imperium:arena/eliminate
