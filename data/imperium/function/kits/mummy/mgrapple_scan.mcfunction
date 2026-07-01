# Run as a linked grapple bobber, at the bobber. Capture its id, (re)detect a hooked entity, then
# hand off to the matching owner (the Mummy whose im_grappleId equals this bobber's).
scoreboard players operation #bid im_grappleId = @s im_grappleId

scoreboard players set #hooked im_grappleId 0
# Fresh contact: a hookable mob/player whose HITBOX the bobber is inside right now -> tag it as this
# hook. We test hitbox intersection (a 1x1x1 cube centered on the bobber via the ~-0.5 offset + dx/
# dy/dz volume) rather than distance to the entity's feet — a tall mob is hooked at body height, so
# a feet-distance check misses it (and a grounded bobber near a mob would false-positive). #im.not_mob
# filters out items, displays, etc. — the same set Smokey's anchor check uses.
execute positioned ~-0.5 ~-0.5 ~-0.5 as @e[dx=0,dy=0,dz=0,type=!fishing_bobber,type=!#im.not_mob,tag=!im.mgrapple_user,sort=nearest,limit=1] run function imperium:kits/mummy/mgrapple_hook
# Sticky hook: once hooked, vanilla stops moving the bobber to the entity, so the distance check
# above only catches the first couple ticks. Keep the hook alive off the persistent tag instead —
# any entity still carrying this bobber's id counts as hooked for as long as the bobber exists.
execute as @e[tag=im.mgrapple_hooked] if score @s im_grappleId = #bid im_grappleId run scoreboard players set #hooked im_grappleId 1

execute as @a if score @s im_grappleId = #bid im_grappleId run function imperium:kits/mummy/mgrapple_owner
