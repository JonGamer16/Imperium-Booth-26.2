# Broadcast the gold-loss notice on a kill. Runs as @s = the resolved killer (kept for the call-site
# gating); the victim carries the im.feed_victim tag and #lost im.temp holds the gold they forfeited.
# Called from arena/on_death.
#
# Broadcast target was @a[tag=summit.battlegrounds.player] — everyone in the Battlegrounds session.
# There is no session standalone, so it goes to @a: in a single continuous arena, players waiting on
# the spawn island are the audience for the feed, not people to hide it from.
#
# NOTE: Summit supplied the "was slain by" death message, so this line only ever carried the gold
# half. Standalone that is vanilla's job — check the showDeathMessages gamerule is on, or this reads
# as an orphaned "X lost N Gold" with nothing saying who killed them.
tellraw @a [{"selector":"@a[tag=im.feed_victim,limit=1]","color":"yellow"},{"text":" lost ","color":"yellow"},{"score":{"name":"#lost","objective":"im.temp"},"color":"gold"},{"text":" Gold","color":"yellow"}]
