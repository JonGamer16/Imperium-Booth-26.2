# RE-ARM FIRST. This function is the reward of imperium:booth/dummy_toggle, and an advancement stays
# granted once earned — so without this revoke the stand fires exactly ONCE per player and is
# then dead forever. It used to be double-wired (Summit's Interactions API called it too, via
# the summit.interactable tag on the interaction), which hid the problem; that API is gone and
# the advancement is now the only path in. Must be the FIRST line — the guards below `return`
# early, and a return before the revoke would leave the stand permanently dormant.
advancement revoke @s only imperium:booth/dummy_toggle

# Dummy interaction (on_right_click, runs as the clicking player): toggle the training dummy —
# summon it if it's gone, dismiss it (husk only; the static marker stays) if it's up. Capture the
# present/absent state FIRST, so respawn and kill_husk can't chain into each other in one tick.
scoreboard players set #hasDummy im.temp 0
# `#minecraft:zombies`, not `type=husk`: if a previous dummy converted to a drowned, an exact-type
# check reads "no dummy" and summons a SECOND one alongside it. See kill_husk.
execute if entity @e[type=#minecraft:zombies,tag=im.dummy] run scoreboard players set #hasDummy im.temp 1
execute if score #hasDummy im.temp matches 0 run function imperium:booth/dummy/respawn
execute if score #hasDummy im.temp matches 1 run function imperium:booth/dummy/kill_husk
