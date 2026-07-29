# Booth exit — hand the player back to Summit's default shield (BSL re-applies
# Resistance V + Saturation once the tag is gone; BG entry re-tags via start_round).
tag @s remove summit.no_regen

# Walking out with a kit on: take it back and return the inventory they arrived with.
# This hook ALSO fires when entering the battlegrounds (BG's enter/success calls
# #summit.booth:exit), which is exactly why inv_return defers a tick and skips arena players —
# there, the kit stays and the cache is held until they actually leave the arena.
#
# ...unless they left via the kitroom warp pad. That pad drops them at -119 71 99, outside every
# booth bounding box, so Summit fires this hook and the kit would be stripped the moment they land —
# the sticker book coming back over the hotbar.0 weapon. The landing room is meant to read as part of
# the dojo (imperium:warp_landing is OR'd into ability_zone for the same reason), so skip the request
# entirely there and let the kit ride until a real exit path asks for it.
#
# Deliberately gated HERE and not in inv_return_tick: this is the only trigger that needs the skip.
# The other two callers must keep working inside the same cube — summit/player_leave (a fighter
# walking out of the arena, whose exit corridor overlaps this zone, and whose items BG has ALREADY
# cleared) and summit/reset_player (/hub, /unstuck, rejoin). Gating the shared tick function would
# strand both of them with an empty inventory and a cache parked in storage.
#
# `unless entity @s[predicate=...]` rather than `unless predicate`: warp_landing is a location_check,
# so it has to be evaluated at the PLAYER's position. The selector arg does that; a bare
# `unless predicate` would read this hook's execution position instead.
execute unless entity @s[predicate=imperium:warp_landing] run function imperium:util/inv_return
