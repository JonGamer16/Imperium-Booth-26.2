# Convert one threshold's worth of banked lifesteal into 1 Blood Bowl soup, if a kit bowl exists.
# Threshold lives in one place: #lsThreshold im_lifesteal (set in main/ability_parameters).
# 'clear ... 1' returns the number removed; gate the soup + drain on a bowl being cleared. Target
# only imperium_kit bowls (the use_remainder of eaten soups) so vanilla bowls aren't consumed.
#
# CALLERS MUST GATE THIS ON A HIT, not just on the bank. The `clear` below matches an item
# component, which is expensive, and the "no bowl" clamp at the bottom leaves im_lifesteal exactly
# at im_lsNeed — so a bank-only `>=` gate re-enters here every single tick for as long as a Livvy
# sits at cap with no empty bowl. loop_enchantments adds im_lsFlag/im_lsDelta to the gate for this
# reason; keep any new call site equally event-driven.
execute store result score #lsCleared im.temp run clear @s bowl[custom_data~{imperium_kit:1b}] 1
execute if score #lsCleared im.temp matches 1.. run loot give @s loot imperium:livvy/soup
# Drain the cost of THIS soup — im_lsNeed as it stands right now, before the escalation below moves
# it. Subtracting (rather than zeroing) keeps the overflow banked toward the next soup.
execute if score #lsCleared im.temp matches 1.. run scoreboard players operation @s im_lifesteal -= @s im_lsNeed
# Escalate the price of the NEXT soup: #lsThreshold + #lsStep * (soups converted this life).
# With #lsStep 0 this recomputes to a constant #lsThreshold, i.e. the escalation is fully off.
execute if score #lsCleared im.temp matches 1.. run scoreboard players add @s im_lsConversions 1
execute if score #lsCleared im.temp matches 1.. run scoreboard players operation @s im_lsNeed = #lsStep im_lifesteal
execute if score #lsCleared im.temp matches 1.. run scoreboard players operation @s im_lsNeed *= @s im_lsConversions
execute if score #lsCleared im.temp matches 1.. run scoreboard players operation @s im_lsNeed += #lsThreshold im_lifesteal
# No bowl available: clamp the bank to the current cost so it can't stockpile past one soup.
execute if score #lsCleared im.temp matches 0 run scoreboard players operation @s im_lifesteal = @s im_lsNeed
