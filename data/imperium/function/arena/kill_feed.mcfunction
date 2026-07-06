# Broadcast the Gold Rush kill feed. Runs as @s = the resolved killer; the victim carries the
# im.feed_victim tag and #lost im.temp holds the gold they forfeited. Called from arena/on_death.
tellraw @a [{"selector":"@a[tag=im.feed_victim,limit=1]","color":"yellow"},{"text":" was slain by ","color":"yellow"},{"selector":"@s","color":"yellow"},{"text":" (","color":"yellow"},{"score":{"name":"#lost","objective":"im.temp"},"color":"gold"},{"text":" Gold)","color":"yellow"}]
