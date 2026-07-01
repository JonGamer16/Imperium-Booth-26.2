# Incremental web refill: hand back ONE web toward the 3-charge stock, then restart the cooldown.
# Do NOT clear first — that would wipe the webs she still holds; the freeze (im_cdUsesB >= im_cdMaxB)
# stops this from over-refilling past 3. The loop keeps im_cdUsesB synced to her real web count, so
# a throw is what unfreezes the slot and lets this fire. Mirror of Meowdy's cd2_arrows.
loot give @s loot imperium:livvy/web
scoreboard players operation @s im_abilityCdB += #Livvy im_abilityCdB
