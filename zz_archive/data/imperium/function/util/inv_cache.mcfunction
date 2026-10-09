# Stash @s's OUTSIDE inventory (what they walked in with) into Summit's Inventory Saving API,
# clearing them in the process. Call this BEFORE any kit item is handed out.
#
# summit's save copies Inventory + equipment into its shard-synced playerdb and then runs
# `clear @s`, so anything given first would be cached as part of the "outside" inventory and
# handed back later — order matters.
#
# Summit auto-loads the cache if the player disconnects, and it survives shard hops, so a
# crash/quit mid-kit can't strand someone's items.

# One cache per player, and it belongs to whoever opened it. If summit.inventory_saved is already
# set, either WE opened it (a kit swap / respawn re-give / booth -> arena hand-off, all of which
# must keep the original cache rather than overwrite it with the kit) or another booth did (theirs
# to return, not ours). Either way: hands off.
execute if entity @s[tag=summit.inventory_saved] run return 0

# im.inv_cached marks the cache as OURS, so imperium:util/inv_restore only ever loads a cache this
# booth opened — and so player_leave can safely return it even after the arena has rotated to
# another booth's session.
tag @s add im.inv_cached
function summit.inventory_management:save
