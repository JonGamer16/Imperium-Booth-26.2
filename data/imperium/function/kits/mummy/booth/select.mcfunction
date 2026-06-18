# Cyborg Mummy — booth selection. Runs as the clicking player (routed from
# imperium:booth/check_stands). Equips the kit via the arena pipeline, then describes it.
scoreboard players set @s givekit 4
function imperium:arena/givekit

tellraw @s ["",{text:"\n  "},{text:"Cyborg Mummy",color:"blue",bold:true},{text:"   The Juggernaut\n",color:"gray",italic:true,bold:false},{text:"  • ",color:"dark_gray"},{text:"Dark Claymore",color:"aqua"},{text:" — heavy reach, mace-class\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Grappling Hook",color:"aqua"},{text:" — reel toward targets\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Energy Crystal",color:"aqua"},{text:" — delayed explosive\n",color:"gray"},{text:"  Durable, hard-hitting frontline.\n",color:"gray",italic:true}]

playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.7 1.4
title @s actionbar {text:"Cyborg Mummy selected",color:"blue"}
