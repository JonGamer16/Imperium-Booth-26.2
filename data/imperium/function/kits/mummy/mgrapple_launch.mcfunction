# Run as the reeling Mummy, at the Mummy, on reel-in with a hooked target. Find my hooked entity
# (matched by shared im_grappleId), capture my position, and yank that entity toward me. Then put
# the rod on cooldown (cd1_rod re-gives it once im_abilityCdA bleeds back to 0).
tag @s remove im.mgrapple_armed

scoreboard players operation #mid im_grappleId = @s im_grappleId
execute store result score #mx im_grappleX run data get entity @s Pos[0] 10000
execute store result score #my im_grappleY run data get entity @s Pos[1] 10000
execute store result score #mz im_grappleZ run data get entity @s Pos[2] 10000

# Yank every entity hooked under this id (normally exactly one) toward me.
execute as @e[tag=im.mgrapple_hooked] if score @s im_grappleId = #mid im_grappleId run function imperium:kits/mummy/mgrapple_yank

scoreboard players operation @s im_abilityCdA = #Mummy im_abilityCdA

playsound minecraft:block.chain.place master @a[distance=..32] ~ ~ ~ 1 0.7
