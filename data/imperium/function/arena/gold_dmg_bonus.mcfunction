# Personal chat feedback on damage-derived gold. Runs as @s (the attacker) on each damage-dealt
# event while im.fighting. damage-gold total = floor(im_statDealt/250); announce any increase
# since the last hit. im.temp2 (@s) holds the delta.
scoreboard players operation @s im.temp2 = @s im_statDealt
scoreboard players operation @s im.temp2 /= const 250
scoreboard players operation @s im.temp2 -= @s im_goldDmgSeen
execute if score @s im.temp2 matches 1.. run scoreboard players operation @s im_goldDmgSeen += @s im.temp2
execute if score @s im.temp2 matches 1.. run tellraw @s [{"text":"[Damage Bonus] +","color":"gold"},{"score":{"name":"@s","objective":"im.temp2"},"color":"gold"},{"text":" Gold","color":"gold"}]
