# Levent the Shulker Knight — booth selection. Runs as the clicking player (routed from
# imperium:booth/check_stands). Equips the kit via the arena pipeline, then describes it.
scoreboard players set @s givekit 5
function imperium:arena/givekit

tellraw @s ["",{text:"\n  "},{text:"Levent the Shulker Knight",color:"light_purple",bold:true},{text:"   The Skyguard\n",color:"gray",italic:true,bold:false},{text:"  • ",color:"dark_gray"},{text:"End Rod",color:"light_purple"},{text:" — agile melee\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Aero Shot",color:"light_purple"},{text:" — gravity-defying arrows\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Gravity Flower",color:"light_purple"},{text:" — reduced gravity while held\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Levitation Arrow",color:"light_purple"},{text:" — float your target\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Reversal Shield",color:"light_purple"},{text:" — punish blockers\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Chorus Fruit",color:"light_purple"},{text:" — teleport healing\n",color:"gray"}]

playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.7 1.4
title @s actionbar {text:"Levent the Shulker Knight selected",color:"light_purple"}
