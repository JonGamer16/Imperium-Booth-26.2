# BG hook (#summit.battlegrounds:api/player_leave, runs as/at the leaving player).
execute unless data storage summit.battlegrounds:database session{booth_id:"imperium"} run return 0
function imperium:summit/end_fighter

# The leaver bailed — drop them from the round so the end-of-round leaderboard doesn't rank a no-show.
tag @s remove im.round

# Walkover: if their exit leaves one (or zero) fighters, the round ends now (#earlyEnd=2). The last
# one standing wins, but grant_win_sticker only awards the Champion sticker if they hold >=5 gold.
# round_over is a no-op if the round already ended (no im.round left), so this can't double-fire.
execute store result score #alive im.temp if entity @a[tag=im.fighting]
execute if score #alive im.temp matches ..1 run scoreboard players set #earlyEnd im.temp 2
execute if score #alive im.temp matches ..1 run function imperium:arena/round_over
