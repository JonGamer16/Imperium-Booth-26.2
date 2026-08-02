# Battlegrounds teleport pad — kit room side. Reward of imperium:booth/warp_from_shulkerbox, which
# earns while a player stands in the box around the pad at -122.5 71 99.5. Sends them back to the
# pagoda. Mirror of booth/warp_kitroom; see that file for why these are advancement-driven.
#
# This is the pad that forced the change: it sits outside every booth bounding box, so no
# ticking_function can ever reach it.
#
# COORD LINK: the box in the advancement is centred on the pad; the destination below is the
# landing. Move either and the other has to move with it.
advancement revoke @s only imperium:booth/warp_from_shulkerbox

tp @s[gamemode=!creative] -68.5 87 -7.5 90 0
