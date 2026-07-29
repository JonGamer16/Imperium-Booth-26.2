# Respawn an active fighter mid-round (player_died hook — respawns while they still have lives;
# arena/on_death eliminates them once im_lives hits 0). Bail if they're no longer a fighter so an
# already-eliminated player can't get re-kitted in the kit room.
execute unless entity @s[tag=im.fighting] run return 0
# TODO(CONFIRM w/ staff): whether player_died fires before or after the vanilla respawn,
# and the arena respawn point(s) — then uncomment/set the tp below.

# Re-equip their kit so a death can't strand them itemless (im_givekit runs clear_kit first,
# so this is safe even if the server keeps inventories on death).
execute if score @s im_lastKit matches 1..7 run scoreboard players operation @s im_givekit = @s im_lastKit
execute if score @s im_lastKit matches 1..7 run function imperium:arena/givekit
execute unless score @s im_lastKit matches 1..7 run function imperium:kits/cliffshield/givekit
