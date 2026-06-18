# Livvy the Vampire Spider — booth selection. Runs as the clicking player (routed from
# imperium:booth/check_stands). Equips the kit via the arena pipeline, then describes it.
scoreboard players set @s givekit 3
function imperium:arena/givekit

tellraw @s ["",{text:"\n  "},{text:"Livvy the Vampire Spider",color:"red",bold:true},{text:"   The Bloodletter\n",color:"gray",italic:true,bold:false},{text:"  • ",color:"dark_gray"},{text:"Lifesteal Fang",color:"red"},{text:" — heals you on hit\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Leap Feather",color:"red"},{text:" — hop with brief Strength\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Throwable Web",color:"red"},{text:" — slows enemies\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Acid Potion",color:"red"},{text:" — Poison + Harming\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Beetroot Soup",color:"red"},{text:" — healing\n",color:"gray"}]

playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.7 1.4
title @s actionbar {text:"Livvy the Vampire Spider selected",color:"red"}
