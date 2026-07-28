# Run as a linked grapple bobber, at the bobber. Capture its id + world position (x10000), decide
# whether it's anchored, then hand off to the matching owner (player whose im_grappleId equals it).
scoreboard players operation #bid im_grappleId = @s im_grappleId
execute store result score #bx im_grappleX run data get entity @s Pos[0] 10000
execute store result score #by im_grappleY run data get entity @s Pos[1] 10000
execute store result score #bz im_grappleZ run data get entity @s Pos[2] 10000

# Anchored = a tangible block sits right under the bobber, OR a hookable entity is inside it.
# (OnGround on fishing bobbers is unreliable, so we test the world instead.) #imperium:im.raycast_pass
# lists air/water/lava/passable plants, so "below is NOT in that tag" = solid ground — which also
# means water/lava casts won't anchor. -0.3 lands inside the floor block: a resting bobber sits
# ~0.125 above the surface, so a shallower check (~-0.1) would still read air. Tune the depth here.
scoreboard players set #anchor im_grappleId 0
execute unless block ~ ~-0.3 ~ #imperium:im.raycast_pass run scoreboard players set #anchor im_grappleId 1
# Hookable entity = one of OUR booth entities (e.g. the training dummy) OR any player. Other booths'
# husks/mannequins are #imperium:human too, so gate the non-player case on our booth tag to keep a
# neighbouring booth from anchoring our grapple.
execute if entity @e[type=#imperium:human,distance=..1.5,tag=summit.booth_entity.imperium] run scoreboard players set #anchor im_grappleId 1
execute if entity @a[distance=..1.5] run scoreboard players set #anchor im_grappleId 1

execute as @a[tag=im.kit_smokey] if score @s im_grappleId = #bid im_grappleId run function imperium:kits/smokey/grapple_owner
