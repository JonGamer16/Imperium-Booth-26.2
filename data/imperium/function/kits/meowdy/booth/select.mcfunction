# Quin Meowdy — booth selection. Runs as the clicking player (routed from
# imperium:booth/check_stands). Equips the kit via the arena pipeline, then describes it.
scoreboard players set @s givekit 2
function imperium:arena/givekit

tellraw @s ["",{text:"\n  "},{text:"Quin Meowdy",color:"gold",bold:true},{text:"   The Duelcat\n",color:"gray",italic:true,bold:false},{text:"  • ",color:"dark_gray"},{text:"Shortsword",color:"gold"},{text:" — quick strikes\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Cat Claw",color:"gold"},{text:" — blinding attack speed, low knockback\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Quickdraw & Birdshot",color:"gold"},{text:" — twin crossbows\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Leap Feather",color:"gold"},{text:" — ground-launch hop\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Salmon",color:"gold"},{text:" — healing\n",color:"gray"}]

playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.7 1.4
title @s actionbar {text:"Quin Meowdy selected",color:"gold"}
