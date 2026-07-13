# Clear kit: strip the current kit, drop the saved selection, and unassign the
# battlegrounds kit (back to register_booth's Cliffshield default).
function imperium:util/clear_kit
scoreboard players set @s im_lastKit 0
scoreboard players reset @s givekit
execute if data storage summit.battlegrounds:database session run function summit.battlegrounds:api/unassign_kit

playsound minecraft:block.note_block.snare master @s ~ ~ ~ 0.7 0.8
title @s actionbar {text:"Kit cleared",color:"gray"}
