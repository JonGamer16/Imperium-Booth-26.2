# Run as a linked grapple bobber, at the bobber. Capture its id, (re)detect a hooked entity, then
# hand off to the matching owner (the Mummy whose im_grappleId equals this bobber's).
scoreboard players operation #bid im_grappleId = @s im_grappleId

scoreboard players set #hooked im_grappleId 0
# Fresh contact: a hookable mob/player the bobber is actually hooked INTO right now -> tag it as
# this hook. A hooked bobber is snapped to its entity's center X/Z each tick, so mgrapple_hook_test
# matches on that (see there) instead of the old 1x1x1 hitbox-intersection cube, which also caught
# anyone the bobber was merely lying next to. distance=..3 is just a cheap pre-filter.
execute store result score #bx im.temp run data get entity @s Pos[0] 10000
execute store result score #by im.temp run data get entity @s Pos[1] 10000
execute store result score #bz im.temp run data get entity @s Pos[2] 10000
execute as @e[type=#imperium:human,distance=..3,tag=!im.mgrapple_user,sort=nearest] run function imperium:kits/mummy/mgrapple_hook_test
# Sticky hook: once hooked, vanilla stops moving the bobber to the entity, so the distance check
# above only catches the first couple ticks. Keep the hook alive off the persistent tag instead —
# any entity still carrying this bobber's id counts as hooked for as long as the bobber exists.
execute as @e[type=#imperium:human,tag=im.mgrapple_hooked] if score @s im_grappleId = #bid im_grappleId run scoreboard players set #hooked im_grappleId 1

execute as @a[tag=im.kit_mummy] if score @s im_grappleId = #bid im_grappleId run function imperium:kits/mummy/mgrapple_owner
