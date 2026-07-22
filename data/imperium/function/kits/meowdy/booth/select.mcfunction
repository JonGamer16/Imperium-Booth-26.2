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
    {color:"white",\
                            text:"Shortsword"},\
    {color:"yellow",\
                            text:" — ⬆ Attack speed\n"},\
    {color:"gold",\
                            text:"  • [Melee] "},\
    {color:"white",\
                            text:"Cat Claw"},\
    {color:"yellow",\
                            text:" — ⬆ Attack Speed | ⬇ Knockback\n"},\
    {color:"gold",\
                            text:"  • [Ranged] "},\
    {color:"white",\
                            text:"Quickdraw & Birdshot"},\
    {color:"yellow",\
                            text:" — Twin crossbows for speed and coverage\n"},\
    {color:"gold",\
                            text:"  • [Consumable] "},\
    {color:"white",\
                            text:"Leap Feather"},\
    {color:"yellow",\
                            text:" — Leap about 15 blocks and briefly gain Speed 2\n"},\
    {color:"gold",\
                text:"  • [Passive] ",},\
    {color:"gray",\
                text:" ⬆ Movement Speed | ⬆ Safe Fall Distance |  ⬆ Sneaking Speed\n",},\
    {color:"gold",\
                            text:"  • [Healing] "},\
    {color:"white",\ 
                            text:"Salmon x16"},\
    {color:"yellow",\
                            text:" — Heals 8 HP\n"}\
]

playsound minecraft:entity.cat.ambient neutral @s ~ ~ ~ 1 0.8
title @s actionbar {text:"Quin Meowdy selected",color:"gold"}
