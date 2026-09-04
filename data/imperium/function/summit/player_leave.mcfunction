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

# Arena emptied: the last fighter just walked out, so close the round out (#earlyEnd=0 — there is
# by definition no survivor to crown, so resolve_match ranks purely by gold).
#
# The threshold is 0, NOT 1. round_over runs end_fighter -> util/clear_kit on EVERY remaining
# im.fighting player, so ending on ..1 stripped the kit off the one fighter still in the arena
# whenever a 1v1 lost a player. That player is unrecoverable: BG only re-runs #api/player_enter for
# someone crossing INTO the bounds, so a fighter already inside never gets re-kitted and spends the
# rest of the session empty-handed. Gold Rush is a timed round with respawns, not a duel — a solo
# fighter keeps playing (and new entrants keep joining) until the session timer fires
# #api/booth_inactive, which is where a time-out end belongs. Last-man-standing by ELIMINATION is
# still an early end; arena/eliminate owns that check (#earlyEnd=1).
execute store result score #alive im.temp if entity @a[tag=im.fighting]
execute if score #alive im.temp matches 0 run scoreboard players set #earlyEnd im.temp 0
execute if score #alive im.temp matches 0 run function imperium:arena/round_over
