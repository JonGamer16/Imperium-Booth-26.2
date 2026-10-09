# Clear Kit stand — strip the current kit and forget the saved selection.
#
# This is now the ONLY thing that takes a kit off a player. It used to be one of three: walking out
# of the booth bounds also stripped it, and the Battlegrounds unassigned it on session exit. Both of
# those are gone — the kit rides with you anywhere (imperium:ability_zone is "is holding a kit"), so
# handing it back has to be deliberate.
#
# The summit.battlegrounds:api/unassign_kit call that sat here is gone with the rest of the BG
# integration, and so is the imperium:util/inv_return half — there is no inventory cache to return
# any more (see arena/givekit, and zz_archive for the parked cache system).
function imperium:util/clear_kit
scoreboard players set @s im_lastKit 0
scoreboard players reset @s im_givekit

playsound minecraft:block.note_block.snare master @s ~ ~ ~ 0.7 0.8
title @s actionbar {text:"Kit cleared",color:"gray"}
