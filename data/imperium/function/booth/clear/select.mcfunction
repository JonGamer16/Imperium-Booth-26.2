# Clear kit: strip the current kit, drop the saved selection, and unassign the
# battlegrounds kit (back to register_booth's Cliffshield default).
function imperium:util/clear_kit
scoreboard players set @s im_lastKit 0
scoreboard players reset @s im_givekit
execute if data storage summit.battlegrounds:database session run function summit.battlegrounds:api/unassign_kit

# Unequipping is the other half of the cache: give back whatever they were carrying before the
# kit. Lands a tick later (see imperium:util/inv_return), which also re-runs clear_kit — harmless,
# both are idempotent.
function imperium:util/inv_return

playsound minecraft:block.note_block.snare master @s ~ ~ ~ 0.7 0.8
title @s actionbar {text:"Kit cleared",color:"gray"}
