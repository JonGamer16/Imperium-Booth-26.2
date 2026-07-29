# Deferred restore dispatch — scheduled 1t out by imperium:util/inv_return.
#
# Skip anyone who is in the battlegrounds: they only left the BOOTH in order to enter the arena,
# where the kit is still legitimately theirs. Their cache stays parked until the BG player_leave
# hook asks again. Same for the booth-rotation case, where BG re-kits everyone mid-arena.
execute as @a[tag=im.inv_return,tag=!summit.battlegrounds.player] run function imperium:util/inv_restore

# Drop the request either way — a skipped player keeps their cache, not a standing request.
# (An offline player keeps the tag; their next join runs #summit:api/reset_player, which asks
# again and resolves it.)
tag @a[tag=im.inv_return] remove im.inv_return
