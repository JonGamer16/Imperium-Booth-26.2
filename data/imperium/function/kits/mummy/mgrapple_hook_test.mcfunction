# Run as a candidate entity near a linked bobber (#bx/#by/#bz im.temp = bobber Pos x10000, set in
# mgrapple_scan). Passes only if the bobber is IN me, not merely next to me.
#
# A bobber hooked into an entity is re-snapped every tick to that entity's own X/Z, at 80% of its
# height (vanilla FishingHook, HOOKED_IN_ENTITY state). So a real hook sits on my center axis; a
# bobber resting beside me is off-axis by at least my half-width. Tolerance 0.4 blocks per axis
# absorbs one tick of movement between the bobber's snap and my own tick, and still rejects any
# neighbor whose center isn't inside a 0.8-wide column around the bobber (bodies would overlap).
# Height: the bobber must sit 0.3-3 blocks above my feet. A real hook is at 80% of my height (>= ~0.48
# even for a crawling player), so the 0.3 floor rejects a grounded bobber I happen to walk onto.
#
# Replaces a 1x1x1 hitbox-intersection cube around the bobber, which "hooked" anyone whose hitbox
# came within half a block of it — the reel-without-hooking bug.
execute store result score #cx im.temp run data get entity @s Pos[0] 10000
scoreboard players operation #cx im.temp -= #bx im.temp
execute unless score #cx im.temp matches -4000..4000 run return fail

execute store result score #cz im.temp run data get entity @s Pos[2] 10000
scoreboard players operation #cz im.temp -= #bz im.temp
execute unless score #cz im.temp matches -4000..4000 run return fail

execute store result score #fy im.temp run data get entity @s Pos[1] 10000
scoreboard players operation #cy im.temp = #by im.temp
scoreboard players operation #cy im.temp -= #fy im.temp
execute unless score #cy im.temp matches 3000..30000 run return fail

function imperium:kits/mummy/mgrapple_hook
