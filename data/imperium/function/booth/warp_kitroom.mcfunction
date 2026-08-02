# Battlegrounds teleport pad — pagoda side. Reward of imperium:booth/warp_from_kitroom, which
# earns while a player stands in the box around the pad at -64.5 87 -7.5. Sends them to the
# Battlegrounds kit room.
#
# WHY ADVANCEMENT-DRIVEN: the pads used to be a per-tick marker scan. booth ticking_functions can
# only drive that while a player is inside the booth bounding boxes, and the RETURN pad
# (booth/warp_shulkerbox) sits out in the kit room, well outside every box — so it could never
# fire. Moving them to persistent_tick didn't help either: that's delivered through the generated
# #summit.booth:persistent_tick function tag, which this server isn't producing, and a missing
# function tag inside #minecraft:tick fails silently. The advancement system runs everywhere
# regardless, needs nothing generated, and costs no per-tick entity scan.
#
# COORD LINK: the box in the advancement is centred on the pad; the destination below is the
# landing. Move either and the other has to move with it. The old im.warp_from_kitroom marker is
# no longer read by anything (see booth/tp_marker_summon).
advancement revoke @s only imperium:booth/warp_from_kitroom

tp @s[gamemode=!creative] -119 71 99 -90 0
