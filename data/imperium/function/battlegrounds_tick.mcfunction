# Persistent tick — runs every tick server-wide via the generated #summit.booth:persistent_tick
# function tag. NOTE: if that tag isn't being generated, NOTHING in this file runs and it fails
# silently (a missing function tag inside #minecraft:tick logs nothing). Check with
# `/function #summit.booth:persistent_tick` before trusting anything here.
#
# The two teleport pads used to live at the top of this file. They're advancement-driven now
# (imperium:booth/warp_from_{kitroom,shulkerbox}) precisely because they can't depend on this
# running — do not add them back here, or they'd fire twice if persistent_tick ever comes online.

execute unless data storage summit.battlegrounds:database session{booth_id: "imperium"} run return 0

execute if entity @a[tag=summit.in_booth.imperium] run return 0

scoreboard players add #5t im.temp 1
scoreboard players add #1s im.temp 1

function imperium:loop_tick
function imperium:loop_enchantments
execute if score #5t im.temp matches 5 run function imperium:loop_5t
execute if score #1s im.temp matches 20 run function imperium:loop_1s

execute if score #5t im.temp matches 5 run scoreboard players set #5t im.temp 0
execute if score #1s im.temp matches 20 run scoreboard players set #1s im.temp 0
