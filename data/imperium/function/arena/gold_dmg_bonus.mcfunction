# Personal chat feedback on damage-derived gold. Runs as @s (the attacker) on each damage-dealt
# event while im.fighting. damage-gold total = floor(im_statDealt/250); announce any increase
# since the last hit. #dmg im.temp holds the delta.
scoreboard players operation #dmg im.temp = @s im_statDealt
scoreboard players operation #dmg im.temp /= #250 imperium.const
scoreboard players operation #dmg im.temp -= @s im_goldDmgSeen
execute if score #dmg im.temp matches 1.. run scoreboard players operation @s im_goldDmgSeen += #dmg im.temp
execute if score #dmg im.temp matches 1.. run tellraw @s [{"text":"[Damage Bonus] +","color":"gold"},{"score":{"name":"#dmg","objective":"im.temp"},"color":"gold"},{"text":" Gold","color":"gold"}]
