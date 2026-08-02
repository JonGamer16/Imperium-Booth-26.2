# Dummy interaction (on_right_click, runs as the clicking player): toggle the training dummy —
# summon it if it's gone, dismiss it (husk only; the static marker stays) if it's up. Capture the
# present/absent state FIRST, so respawn and kill_husk can't chain into each other in one tick.
scoreboard players set #hasDummy im.temp 0
# Tag-only, no `type=husk`: if a previous dummy converted to a drowned, the old type-scoped check
# read "no dummy" and would summon a SECOND one alongside it. See kill_husk.
execute if entity @e[tag=im.dummy] run scoreboard players set #hasDummy im.temp 1
execute if score #hasDummy im.temp matches 0 run function imperium:booth/dummy/respawn
execute if score #hasDummy im.temp matches 1 run function imperium:booth/dummy/kill_husk
