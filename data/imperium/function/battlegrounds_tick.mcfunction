# Persistent tick — runs every tick server-wide via the generated #summit.booth:persistent_tick
# function tag. NOTE: if that tag isn't being generated, NOTHING in this file runs and it fails
# silently (a missing function tag inside #minecraft:tick logs nothing). Check with
# `/function #summit.booth:persistent_tick` before trusting anything here.
#
# The two teleport pads used to live at the top of this file. They're advancement-driven now
# (imperium:booth/warp_from_{kitroom,shulkerbox}) precisely because they can't depend on this
# running — do not add them back here, or they'd fire twice if persistent_tick ever comes online.

# SOLE DRIVER of all four loops, in every context. booth_definition no longer registers
# ticking_functions; see the note below for why.
#
# Run the loops whenever there is anything for them to do: our battlegrounds session is live
# (fighters in the arena) OR somebody is inside the booth (kit stands, training dummy). Idle
# otherwise. Both branches are needed — neither population implies the other.
#
# WHY NOT ticking_functions: booth ticking_functions only fire while a player is inside the booth
# bounding boxes, and the arena sits OUTSIDE every box — so they can never keep an arena fight
# ticking (see `bsl advice.txt`). They can only ever duplicate what this function already does, and
# because loop_tick is one monolithic pass over global @a/@e selectors, "both drivers live at once"
# means every timed mechanic runs at double speed. That forced the guard this replaces:
#
#     execute if entity @a[tag=summit.in_booth.imperium] run return 0
#
# which killed the ENTIRE arena loop for every fighter the moment ANY player stood in the booth —
# no ability charging, no Mummy energy, no Rastus drought/parry, no gold. Intermittent by nature,
# and guaranteed by arena/eliminate, which teleports eliminated fighters to -78 87 -8 — inside the
# pagoda_center box. Deleting the redundant driver is what makes the guard unnecessary.
execute \
    unless data storage summit.battlegrounds:database session{booth_id: "imperium"} \
    unless entity @a[tag=summit.in_booth.imperium] \
    run return 0

scoreboard players add #5t im.temp 1
scoreboard players add #1s im.temp 1

function imperium:loop_tick
function imperium:loop_enchantments
execute if score #5t im.temp matches 5 run function imperium:loop_5t
execute if score #1s im.temp matches 20 run function imperium:loop_1s

execute if score #5t im.temp matches 5 run scoreboard players set #5t im.temp 0
execute if score #1s im.temp matches 20 run scoreboard players set #1s im.temp 0
