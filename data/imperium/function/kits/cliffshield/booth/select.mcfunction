# Jeru Cliffshield — booth selection. Runs as the clicking player (routed from
# imperium:booth/check_stands). Equips the kit via the arena pipeline, then describes it.
scoreboard players set @s givekit 1
function imperium:arena/givekit

tellraw @s ["",{text:"\n  "},{text:"Jeru Cliffshield",color:"yellow",bold:true},{text:"   The Bulwark\n",color:"gray",italic:true,bold:false},{text:"  • ",color:"dark_gray"},{text:"Silver Glaive",color:"yellow"},{text:" — long reach, slow, low knockback\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Steel Broadsword",color:"yellow"},{text:" — Sweeping Edge, knockback resist\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Light Crossbow",color:"yellow"},{text:" — Power I bolts\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Shield",color:"yellow"},{text:" — 30 HP block, wide angle\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Rook Rush",color:"yellow"},{text:" — burst of Speed\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Mushroom Stew",color:"yellow"},{text:" — healing\n",color:"gray"}]

playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.7 1.4
title @s actionbar {text:"Jeru Cliffshield selected",color:"yellow"}
