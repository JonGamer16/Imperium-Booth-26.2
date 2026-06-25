# Warforged Mummy — booth selection. Runs as the clicking player (routed from
# the kit's booth/click handler). Equips the kit via the arena pipeline, then describes it.
scoreboard players set @s givekit 4
function imperium:arena/givekit

tellraw @s \
[   "",\
    {\
                                text:"\n  "},\
    {color:"aqua",bold:true,\
                                text:"The Warforged Mummy \n\n"},\
    {color:"gold",\
                                text:"  • Attributes: "},\
    {color:"gray",\
                                text:"+ Knockback Resist; - Speed; + Scale\n"},\
    {color:"gold",\
                                text:"  • [Melee] "},\
    {color:"aqua",\
                                text:"Dark Claymore"},\
    {color:"gray",\
                                text:" — + Reach; - Attack Speed; Can perform vertical smash attacks\n"},\
    {color:"gold",\
                                text:"  • [Consumable] "},\
    {color:"aqua",\
                                text:"Grappling Hook"},\
    {color:"gray",\
                                text:" — Forcefully reels targets in, dealing damage; consumes Energy\n"},\
    {color:"gold",\
                                text:"  • [Healing] "},\
    {color:"aqua",\
                                text:"Energy Crystal"},\
    {color:"gray",\
                                text:" — Consume to regenerate HP and Energy, or Crouch and place on the ground for damage, knockback, and Absorption to yourself\n"},\
    {color:"gold",\
                                text:"  • [Special] "},\
    {color:"aqua",\
                                text:"Golem Toss"},\
    {color:"gray",\
                                text:" — Crouch to charge an attack that launches enemies upward; consumes Energy\n"},\
    {color:"gold",\
                                text:"  • [Special] "},\
    {color:"aqua",\
                                text:"Energy Barrier"},\
    {color:"gray",\
                                text:" — Crouching also blocks incoming damage from all angles; consumes Energy\n"},\
]

playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.7 1.4
title @s actionbar {text:"Mummy selected",color:"blue"}
