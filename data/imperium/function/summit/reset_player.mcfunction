# Summit reset hook (#summit:api/reset_player): undo anything imperium may have left on a
# player. Kit items, attribute modifiers, ability tags/scores all live in clear_kit; the
# base attribute writes are gone (they ride the kit items now), so no base restore needed.
function imperium:util/clear_kit

# ...including the inventory cache, so /hub, /unstuck or a rejoin can't leave someone's items
# parked in storage. No-op if we never cached for them.
function imperium:util/inv_return

tag @s remove im.fighting
tag @s remove summit.no_regen
scoreboard players reset @s im_givekit
