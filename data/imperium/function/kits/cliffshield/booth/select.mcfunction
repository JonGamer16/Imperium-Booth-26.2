# Jeru Cliffshield — booth selection. Runs as the clicking player (routed from
# the kit's booth/click handler). Equips the kit via the arena pipeline, then describes it.
scoreboard players set @s im_givekit 1
function imperium:arena/givekit
function imperium:kits/cliffshield/booth/assign

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
                            text:" - ⬆ Reach | ⬆ Damage | ⬇ Attack Speed | ⬇ Knockback\n"},\
    {color:"gold",\
                            text:"  • [Melee] "},\
    {color:"yellow",\
                            text:"Steel Broadsword"},\
    {color:"gray",\
                            text:" — ⬆ Sweeping Damage; ⬆ KB Resist\n"},\
    {color:"gold",\
                            text:"  • [Ranged] "},\
    {color:"yellow",\
                            text:"Heavy Crossbow"},\
    {color:"gray",\
                            text:" — ⬆ Arrow Damage\n"},\
    {color:"gold",\
                            text:"  • [Consumable] "},\
    {color:"yellow",\
                            text:"Tower Shield"},\
    {color:"gray",\
                            text:" — Blocks 100% KB | 0.35sec Blocking Delay | 60° Blocking Angle\n"},\
    {color:"gold",\
                            text:"  • [Consumable] "},\
    {color:"yellow",\
                            text:"Rook Rush"},\
    {color:"gray",\
                            text:" — Extreme Speed for 1 second\n"},\
    {color:"gold",\
                            text:"  • [Passive] ",},\
    {color:"gray",\
                            text:"— ⬆ Step Height\n",},\
    {color:"gold",\
                            text:"  • [Healing] "},\
    {color:"yellow",\
                            text:"Mushroom Stew x16"},\
    {color:"gray",\
                            text:" — Heals 8 HP\n"}\
]

playsound minecraft:entity.zombie.attack_iron_door neutral @s ~ ~ ~ 0.7 1
title @s actionbar {text:"Jeru Cliffshield selected",color:"yellow"}