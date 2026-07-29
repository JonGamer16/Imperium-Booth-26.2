# Grapple rod break signal (advancement-driven). Fires from imperium:combat/rod_broke on
# minecraft:item_durability_changed, as the holder, the moment a kit fishing rod's durability
# runs out ("durability": {"max": 0} = the hit that breaks it).
#
# WHY THIS EXISTS: both grapple trackers tell a real reel apart from a slot-change cancel by
# checking whether the rod is still in the offhand (im.grapple_user / im.mgrapple_user). The reel
# that spends the last durability point removes the rod, so that final — usually best — grapple
# reads as a cancel and is silently dropped. This tag says "it's gone because it BROKE", which a
# slot swap never produces, so the trackers can fire that last launch.
#
# use_remainder cannot do this job: it only fires when a stack COUNT decreases after use
# (soup -> bowl), never on a durability break. See loot_table/{smokey,mummy}/fishing_rod.
#
# Serves both rods — Smokey's Recoil Rod and Mummy's Grapple Rod are both fishing_rod with
# custom_data {imperium_kit:1b}, and they can never be held by the same player.
# Cleared at the bottom of imperium:loop_tick, one tick later, once both trackers have read it.
advancement revoke @s only imperium:combat/rod_broke
tag @s add im.rod_broke
