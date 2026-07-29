# Take the kit off @s and hand back the outside inventory cached by imperium:util/inv_cache.
# Only ever reached via imperium:util/inv_return_tick (one tick after the triggering event, and
# only for players who are not in the arena).

# clear_kit first: summit's load runs its own `clear @s`, so the kit ITEMS would go either way —
# but the ability tags, cooldown scores and attribute modifiers ride on the PLAYER, not the items.
# Without this, someone who walks out mid-charge keeps Levent's attack modifiers outside the booth.
function imperium:util/clear_kit

# Restores Inventory + equipment to their original slots and drops summit.inventory_saved, which
# re-arms inv_cache for the next kit. Gated on OUR ownership marker so we never consume a cache
# another booth opened; safe to reach for a player who never touched a kit stand, since they have
# neither tag.
execute if entity @s[tag=im.inv_cached] run function summit.inventory_management:load
tag @s remove im.inv_cached
