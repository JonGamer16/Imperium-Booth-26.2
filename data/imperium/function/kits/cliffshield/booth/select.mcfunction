# Jeru Cliffshield — booth selection. Runs as the clicking player (routed from
# the kit's booth/click handler). Equips the kit via the arena pipeline, then describes it.
scoreboard players set @s givekit 1
function imperium:arena/givekit

tellraw @s \
[   "",\
    {\
                            text:"\n  "},\
    {color:"yellow",bold:true,\
                            text:"Jeru Cliffshield - The Wandering Sentinel"},\
    {bold:false,\
                            text:"\n\n"},\
    {color:"gold",\
                            text:"  • [Melee] "},\
    {color:"yellow",\
                            text:"Silver Glaive"},\
    {color:"gray",\
                            text:" — Increased Reach and Damage; - Attack Speed; - Knockback (KB) Resist\n"},\
    {color:"gold",\
                            text:"  • [Melee] "},\
    {color:"yellow",\
                            text:"Steel Broadsword"},\
    {color:"gray",\
                            text:" — Sweeping Edge; KB Resist\n"},\
    {color:"gold",\
                            text:"  • [Ranged] "},\
    {color:"yellow",\
                            text:"Heavy Crossbow"},\
    {color:"gray",\
                            text:" — Power 1 bolts\n"},\
    {color:"gold",\
                            text:"  • [Consumable] "},\
    {color:"yellow",\
                            text:"Tower Shield"},\
    {color:"gray",\
                            text:" — + Delay, - Blocking Angle, - KB Blocked\n"},\
    {color:"gold",\
                            text:"  • [Consumable] "},\
    {color:"yellow",\
                            text:"Rook Rush"},\
    {color:"gray",\
                            text:" — Extreme Speed for 1 second\n"},\
    {color:"gold",\
                            text:"  • [Healing] "},\
    {color:"yellow",\
                            text:"Mushroom Stew x16"},\
    {color:"gray",\
                            text:" — Heals 8 HP\n"}\
]

playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.7 1.4
title @s actionbar {text:"Jeru Cliffshield selected",color:"yellow"}
