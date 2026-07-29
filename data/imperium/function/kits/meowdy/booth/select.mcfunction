# Quin Meowdy — booth selection. Runs as the clicking player (routed from
# the kit's booth/click handler). Equips the kit via the arena pipeline, then describes it.
scoreboard players set @s im_givekit 2
function imperium:arena/givekit
function imperium:kits/meowdy/booth/assign

tellraw @s \
[   "",\
    {text:"\n  "},\
    {color:"gold",bold:true,\
                            text:"Quin Meowdy - The Gunslinging Cowcat \n\n"},\
    {color:"gold",\
                            text:"  • [Melee] "},\
    {color:"yellow",\
                            text:"Shortsword"},\
    {color:"gray",\
                            text:" — ⬆ Attack speed\n"},\
    {color:"gold",\
                            text:"  • [Melee] "},\
    {color:"yellow",\
                            text:"Cat Claw"},\
    {color:"gray",\
                            text:" — ⬆ Attack Speed | ⬇ Knockback\n"},\
    {color:"gold",\
                            text:"  • [Ranged] "},\
    {color:"yellow",\
                            text:"Quickdraw & Birdshot"},\
    {color:"gray",\
                            text:" — Twin crossbows for speed and coverage\n"},\
    {color:"gold",\
                            text:"  • [Consumable] "},\
    {color:"yellow",\
                            text:"Leap Feather"},\
    {color:"gray",\
                            text:" — Leap about 15 blocks and briefly gain Speed 2\n"},\
    {color:"gold",\
                text:"  • [Passive] ",},\
    {color:"gray",\
                text:" ⬆ Movement Speed | ⬆ Safe Fall Distance |  ⬆ Sneaking Speed\n",},\
    {color:"gold",\
                            text:"  • [Healing] "},\
    {color:"yellow",\ 
                            text:"Salmon x16"},\
    {color:"gray",\
                            text:" — Heals 8 HP\n"}\
]

playsound minecraft:entity.cat.ambient neutral @s ~ ~ ~ 1 0.8
title @s actionbar {text:"Quin Meowdy selected",color:"gold"}
