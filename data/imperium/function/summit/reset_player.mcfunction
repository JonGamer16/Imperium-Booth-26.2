# Summit reset hook (#summit:api/reset_player): undo anything imperium may have left on a
# player. Kit items, attribute modifiers, ability tags/scores all live in clear_kit; the
# base attribute writes are gone (they ride the kit items now), so no base restore needed.
function imperium:util/clear_kit
tag @s remove im.fighting
tag @s remove summit.no_regen
scoreboard players reset @s givekit
