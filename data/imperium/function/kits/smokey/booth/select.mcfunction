# Smokey Bat — booth selection. Runs as the clicking player (routed from
# imperium:booth/check_stands). Equips the kit via the arena pipeline, then describes it.
scoreboard players set @s givekit 7
function imperium:arena/givekit

tellraw @s ["",{text:"\n  "},{text:"Smokey Bat",color:"gold",bold:true},{text:"   The Bounty Hunter\n",color:"gray",italic:true,bold:false},{text:"  • ",color:"dark_gray"},{text:"Steel Dagger",color:"gold"},{text:" — fast and light\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Bearded Hatchet",color:"gold"},{text:" — heavier chop\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Grappling Rod",color:"gold"},{text:" — pull yourself around\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Marking Dart",color:"gold"},{text:" — Glowing + bonus melee damage\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Smoke Bomb",color:"gold"},{text:" — Invisibility + Speed\n",color:"gray"},{text:"  • ",color:"dark_gray"},{text:"Rabbit Stew",color:"gold"},{text:" — healing\n",color:"gray"}]

playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.7 1.4
title @s actionbar {text:"Smokey Bat selected",color:"gold"}
