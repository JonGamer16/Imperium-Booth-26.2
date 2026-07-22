# Random kit: roll 1..7 and route through that kit's normal booth select, so the roll
# equips in-booth AND registers the battlegrounds assignment exactly like a manual pick.
execute store result score @s im.temp run random value 1..7
execute if score @s im.temp matches 1 run return run function imperium:kits/cliffshield/booth/click
execute if score @s im.temp matches 2 run return run function imperium:kits/meowdy/booth/click
execute if score @s im.temp matches 3 run return run function imperium:kits/livvy/booth/click
execute if score @s im.temp matches 4 run return run function imperium:kits/mummy/booth/click
execute if score @s im.temp matches 5 run return run function imperium:kits/levent/booth/click
execute if score @s im.temp matches 6 run return run function imperium:kits/rastus/booth/click
execute if score @s im.temp matches 7 run return run function imperium:kits/smokey/booth/click
