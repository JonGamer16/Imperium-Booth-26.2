# Booth entry hook. Driven by the rising edge in imperium:tick (was booth_definition.on_player_enter,
# delivered by the Summit booth runtime). Runs once, as the entering player.

# Close the latch imperium:tick compares against. Owned here so the edge cannot re-fire while the
# player stays inside; imperium:booth/exit_booth opens it again on the way out.
tag @s add im.in_safe_zone

# Back on the island = out of the fight. Continuous FFA has no rounds, so stepping into the safe
# zone is the only thing that ends your participation. Self-guards if you were never fighting.
function imperium:ffa/leave

title @s subtitle {color:"gold",text:"by JonGamer16"}
title @s title {color:"gold",text:"Imperium Mundi"}

# NO sticker grant. This used to be
#     advancement grant @s only summit.sticker_book:imperium/enter_booth
# generated from booth_definition.sticker_book, which does not exist standalone. The sticker book
# was a Summit booth feature rather than anything this pack owned, so it is gone rather than
# reimplemented; the title card above is the welcome now. See booth/check_lore for the one piece of
# that system worth keeping — the per-fighter lore tags.
