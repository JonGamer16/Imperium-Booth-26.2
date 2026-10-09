# Booth exit hook. Driven by the falling edge in imperium:tick (was booth_definition.on_player_exit,
# delivered by the Summit booth runtime). Runs once, as the leaving player.

# Open the latch imperium:tick compares against, so a re-entry fires enter_booth again.
tag @s remove im.in_safe_zone

# Off the island = in the fight. Self-guards on already-fighting and on carrying no kit, so a
# player who wanders out empty-handed is simply not a participant.
function imperium:ffa/join

# THE KIT NOW RIDES ALONG, deliberately. This hook used to call imperium:util/inv_return, which
# defers a tick and lands in util/inv_restore -> util/clear_kit: walking out of the pagoda stripped
# your kit and handed back the inventory Summit had cached. Both halves of that are gone standalone.
#
#   1. There is no inventory cache any more. It was summit.inventory_management:save/load, a shard-
#      synced server API with no vanilla equivalent (vanilla cannot write a player's Inventory via
#      /data at all), and it was dropped rather than reimplemented.
#   2. Stripping the kit here would contradict the ability gate. imperium:ability_zone is now
#      "is holding a kit" (im.kitted) rather than "is inside the booth", precisely so kits can be
#      taken out and used anywhere — so confiscating the kit at the door would make that impossible.
#
# The Clear Kit stand (imperium:booth/clear/select -> util/clear_kit) is now the only thing that
# takes a kit off you, and it is deliberate rather than positional.

# Training dummy: the booth may have just emptied, which is the one state where nothing is watching
# the dummy (its tether lives in loop_5t, which idles once nobody is inside the boxes). Hand off to a
# scheduled sweep instead of checking inline — see booth/dummy/empty_check for why the delay matters.
# `replace` is what makes this safe for a group leaving together: a whole tour walking out queues ONE
# check, not one per person, and the last exit's schedule is the one that survives.
schedule function imperium:booth/dummy/empty_check 10t replace
