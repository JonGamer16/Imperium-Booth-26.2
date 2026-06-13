# Convert one threshold's worth of banked lifesteal into 1 Blood Bowl soup, if a bowl exists.
# Threshold lives in one place: #lsThreshold im_lifesteal (set in main.mcfunction).
# 'clear ... 1' returns the number removed; gate the soup + drain on a bowl being cleared.
execute store result score #lsCleared im.temp run clear @s minecraft:bowl 1
execute if score #lsCleared im.temp matches 1.. run loot give @s loot imperium:livvy/soup
execute if score #lsCleared im.temp matches 1.. run scoreboard players operation @s im_lifesteal -= #lsThreshold im_lifesteal
# No bowl available: clamp the bank to the threshold so it can't stockpile past one soup.
execute if score #lsCleared im.temp matches 0 run scoreboard players operation @s im_lifesteal = #lsThreshold im_lifesteal
