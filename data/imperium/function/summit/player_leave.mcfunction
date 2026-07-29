# BG hook (#summit.battlegrounds:api/player_leave, runs as/at the leaving player).

# Give back the inventory they had before the kit. ABOVE the session guard on purpose: the arena
# rotates booths while players stay inside, so someone we kitted can easily leave under a different
# booth's session — and that guard would otherwise strand their items in storage. im.inv_cached is
# only on players WE cached, so this can't touch anyone else's cache or another booth's flow.
# Deferred a tick on purpose too: BG's leave path runs `clear @s *` right after this hook returns,
# and drops summit.battlegrounds.player just before it — so by the time inv_return_tick fires, the
# clear is done and the arena skip no longer applies.
execute if entity @s[tag=im.inv_cached] run function imperium:util/inv_return

# Only act while imperium's session is the active one.
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
