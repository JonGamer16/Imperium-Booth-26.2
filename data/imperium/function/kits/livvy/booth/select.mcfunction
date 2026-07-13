# Livvy the Vampire Spider — booth selection. Runs as the clicking player (routed from
# the kit's booth/click handler). Equips the kit via the arena pipeline, then describes it.
scoreboard players set @s givekit 3
function imperium:arena/givekit
function imperium:kits/livvy/booth/assign

tellraw @s \
[   "",\
    {           text:"\n  "},\
    {color:"red",bold:true,\
                text:"Livvy - The Vampire Spider \n\n"},\
    {color:"gold",\
                text:"  • [Melee] ",},\
    {color:"red",\
                text:"Lifesteal Fang",},\
    {color:"gray",\
                text:" — + Critical Damage; Attack to refill bowls with healing soup\n",},\
    {color:"gold",\
                text:"  • [Consumable] ",},\
    {color:"red",\
                text:"Leap Feather",},\
    {color:"gray",\
                text:" — Leap into the air and gain 1 second of Strength\n",},\
    {color:"gold",\
                text:"  • [Consumable] ",},\
    {color:"red",\
                text:"Throwable Web",},\
    {color:"gray",\
                text:" — Briefly traps enemies\n",},\
    {color:"gold",\
                text:"  • [Consumable] ",},\
    {color:"red",\
                text:"Acid Potion",},\
    {color:"gray",\
                text:" — Inflicts Harming 1 and rapid Poison that also powers up your melee attacks\n",},\
    {color:"gold",\
                text:"  • [Passive] ",},\
    {color:"gray",\
                text:" + Movement Speed; + Step Height; + Safe Fall Distance; + Sneaking Speed\n",},\
    {color:"gold",\
                text:"  • [Healing] ",},\
    {color:"red",\
                text:"Beetroot Soup x12",},\
    {color:"gray",\
                text:" — Heals 8 HP, and leaves a bowl that can be refilled\n",}]

playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.7 1.4
title @s actionbar {text:"Livvy selected",color:"red"}
