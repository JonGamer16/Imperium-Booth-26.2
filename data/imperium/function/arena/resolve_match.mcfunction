# Interval end (Gold Rush): score everyone and announce the winner(s). Called from the Summit
# booth_inactive hook (guarded) once per interval; usable locally too. Ties announce all top scorers.
execute as @a[tag=im.fighting] run function imperium:arena/calc_gold

# Highest gold among the fighters (start below any real score; -1 also means "nobody fighting").
scoreboard players set #topGold im.temp -1
execute as @a[tag=im.fighting] run scoreboard players operation #topGold im.temp > @s im_gold
execute if score #topGold im.temp matches -1 run return 0

tellraw @a [{"text":"── Gold Rush results ──","color":"gold"}]
execute as @a[tag=im.fighting] if score @s im_gold = #topGold im.temp run tellraw @a [{"text":"Winner: ","color":"gold"},{"selector":"@s","color":"yellow"},{"text":" with ","color":"gray"},{"score":{"name":"@s","objective":"im_gold"},"color":"gold"},{"text":" gold!","color":"gray"}]

# TODO(Slice 3): grant the champion sticker to @a[tag=im.fighting] with im_gold = #topGold im.temp
