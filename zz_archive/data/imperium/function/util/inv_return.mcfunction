# Request that @s's cached outside inventory be handed back — NEXT tick, not right now.
#
# The deferral is load-bearing, for two separate reasons:
#   1. Battlegrounds' own leave path runs `clear @s *` immediately AFTER our
#      #summit.battlegrounds:api/player_leave hook, so an in-line restore would be wiped.
#   2. ENTERING the battlegrounds fires the booth-exit hook first (summit.battlegrounds's
#      enter/success calls #summit.booth:exit before tagging + kitting the player). Waiting a tick
#      lets inv_return_tick see summit.battlegrounds.player and KEEP the cache, instead of handing
#      it back a tick before the arena clears everything again.
#
# schedule (not one of our booth loops) because ticking_functions only run while a player is
# inside the booth's bounding boxes — and every restore trigger is a player on their way out.
# `replace` keeps at most one dispatch pending; it's a broadcast to every tagged player, so a
# second request in the same window costs nothing (worst case it delays a co-pending restore 1t).
tag @s add im.inv_return
schedule function imperium:util/inv_return_tick 1t replace
