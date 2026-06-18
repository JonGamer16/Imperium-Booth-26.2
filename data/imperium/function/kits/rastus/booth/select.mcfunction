# Rastus the Duelist — booth selection. Runs as the clicking player (routed from
# imperium:booth/check_stands). Equips the kit via the arena pipeline, then describes it.
scoreboard players set @s givekit 6
function imperium:arena/givekit

tellraw @s ["",{text:"\n  "},{text:"Rastus the Duelist",color:"blue",bold:true},{text:"   The Fencer\n",color:"gray",italic:true,bold:false},{text:"  • ",color:"dark_gray"},{text:"Light Rapier",color:"aqua"},{text:" — lightning attack speed, low knockback\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Buckler",color:"aqua"},{text:" — quick guard, fragile\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Splash Healing II",color:"aqua"},{text:" — healing\n",color:"gray"}]

playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.7 1.4
title @s actionbar {text:"Rastus the Duelist selected",color:"blue"}
