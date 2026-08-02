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

# Training dummy: the booth may have just emptied, which is the one state where nothing is watching
# the dummy (its tether lives in loop_5t, a booth ticking_function). Hand off to a scheduled sweep
# instead of checking inline — see booth/dummy/empty_check for why the delay is load-bearing.
# `replace` is what makes this safe for a group leaving together: a whole tour walking out queues
# ONE check, not one per person, and the last exit's schedule is the one that survives.
#
# Deliberately NOT gated on the warp_landing skip above. That skip exists so the kit rides along to
# the landing room; the dummy has nothing to do with the leaver's inventory, and someone taking the
# kitroom pad has left the booth boxes just as completely as someone walking out the front.
schedule function imperium:booth/dummy/empty_check 10t replace
