# Levent the Shulker Knight — booth selection. Runs as the clicking player (routed from
# the kit's booth/click handler). Equips the kit via the arena pipeline, then describes it.
scoreboard players set @s givekit 5
function imperium:arena/givekit

tellraw @s \
[   "",\
    {\
        text:"\n  "},\
    {color:"light_purple",bold:true,\
                            text:"Levent - The Shulker Knight \n\n",},\
    {color:"gold",\
                            text:"  • [Melee] ",},\
    {color:"light_purple",\
                            text:"Light Rod",},\
    {color:"gray",\
                            text:" — Extreme attack speed; decreased knockback\n",},\
    {color:"gold",\
                            text:"  • [Ranged] ",},\
    {color:"light_purple",\
                            text:"Aero Shot",},\
    {color:"gray",\
                            text:" — Fires straight-flying arrows that inflict Levitation\n",},\
    {color:"gold",\
                            text:"  • [Special] ",},\
    {color:"light_purple",\
                            text:"Gravity Control",},\
    {color:"gray",\
                            text:" — Hold Jump to float upwards\n",},\
    {color:"gold",\
                            text:"  • [Consumable] ",},\
    {color:"light_purple",\
                            text:"Reversal Shield",},\
    {color:"gray",\
                            text:" — Sneak while blocking to teleport behind attackers\n",},\
    {color:"gold",\
                            text:"  • [Healing] ",},\
    {color:"light_purple",\
                            text:"Chorus Fruit x16",},\
    {color:"gray",\
                            text:" — Heals 8 HP and teleports you randomly\n",}]

playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.7 1.4
title @s actionbar {text:"Levent selected",color:"light_purple"}
