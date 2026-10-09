# Re-equip a fighter's kit after death. Called from imperium:loop_1s once the player is confirmed
# alive again (see the im.await_kit handoff there and in arena/on_death).
#
# Drops the flag FIRST so a failure below can't leave it set and re-fire every second.
tag @s remove im.await_kit

# Bail if they stopped being a fighter between dying and respawning (walked back onto the spawn
# island, or had the kit cleared) — re-kitting them there would be wrong.
execute unless entity @s[tag=im.fighting] run return 0

# Re-give whatever they were last using. im_givekit runs clear_kit first, so this is safe whether or
# not the world has keepInventory on. Falls back to Cliffshield if they somehow have no last kit.
execute if score @s im_lastKit matches 1..7 run scoreboard players operation @s im_givekit = @s im_lastKit
execute if score @s im_lastKit matches 1..7 run function imperium:arena/givekit
execute unless score @s im_lastKit matches 1..7 run function imperium:kits/cliffshield/givekit
