# Broadcast the Gold Rush gold-loss notice. Summit provides the "was slain by" death message now,
# so this is reduced to just the gold the victim forfeited. Runs as @s = the resolved killer (kept
# for the call-site gating); the victim carries the im.feed_victim tag and #lost im.temp holds the
# gold they forfeited. Called from arena/on_death.
tellraw @a[tag=summit.battlegrounds.player] [{"selector":"@a[tag=im.feed_victim,limit=1]","color":"yellow"},{"text":" lost ","color":"yellow"},{"score":{"name":"#lost","objective":"im.temp"},"color":"gold"},{"text":" Gold","color":"yellow"}]
