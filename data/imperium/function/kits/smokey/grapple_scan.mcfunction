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
execute if entity @e[distance=..1.5,type=!fishing_bobber,type=!#im.not_mob] run scoreboard players set #anchor im_grappleId 1

execute as @a if score @s im_grappleId = #bid im_grappleId run function imperium:kits/smokey/grapple_owner
