# Full player reset — undo anything imperium may have left on a player. Kit items, attribute
# modifiers, ability tags and cooldown scores all live in clear_kit; the base attribute writes are
# gone (they ride the kit items now), so no base restore is needed.
#
# This was #summit:api/reset_player, the hook Summit called on /hub, /unstuck and rejoin. There is
# no such hook standalone, so nothing calls this automatically — it is a manual repair tool:
#
#     /execute as <player> run function imperium:util/reset_player
#
# Worth reaching for if someone ends up with a stuck ability tag or a modifier that outlived its kit.
function imperium:util/clear_kit

tag @s remove im.fighting
tag @s remove im.in_safe_zone
tag @s remove im.await_kit
scoreboard players reset @s im_givekit
