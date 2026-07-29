# Warforged Mummy — booth selection. Runs as the clicking player (routed from
# the kit's booth/click handler). Equips the kit via the arena pipeline, then describes it.
scoreboard players set @s im_givekit 4
function imperium:arena/givekit
function imperium:kits/mummy/booth/assign

tellraw @s \
[   "",\
    {\
                                text:"\n  "},\
    {color:"aqua",bold:true,\
                                text:"The Warforged Mummy \n\n"},\
    {color:"gold",\
                                text:"  • Attributes: "},\
    {color:"gray",\
                                text:"⬆ Knockback Resist\n"},\
    {color:"gold",\
                                text:"  • [Melee] "},\
    {color:"aqua",\
                                text:"Dark Claymore"},\
    {color:"gray",\
                                text:" — ⬆ Reach | ⬇ Attack Speed | Can perform mace smash attacks (costs Energy)\n"},\
    {color:"gold",\
                                text:"  • [Consumable] "},\
    {color:"aqua",\
                                text:"Grappling Hook"},\
    {color:"gray",\
                                text:" — Forcefully reels targets in; while hooked, Golem Toss launches you up with the target\n"},\
    {color:"gold",\
                                text:"  • [Healing] "},\
    {color:"aqua",\
                                text:"Energy Crystal"},\
    {color:"gray",\
                                text:" — Consume to regenerate HP and Energy, or Crouch and place on the ground for damage, knockback, and restore less Energy\n"},\
    {color:"gold",\
                                text:"  • [Special] "},\
    {color:"aqua",\
                                text:"Golem Toss"},\
    {color:"gray",\
                                text:" — Crouch to charge an attack that launches enemies upward (costs Energy)\n"},\
    {color:"gold",\
                                text:"  • [Special] "},\
    {color:"aqua",\
                                text:"Energy Barrier"},\
    {color:"gray",\
                                text:" — Crouching also blocks incoming damage from all angles (costs Energy)\n"},\
]

playsound minecraft:block.enchantment_table.use neutral @s ~ ~ ~ 0.7 0.5
title @s actionbar {text:"Mummy selected",color:"blue"}
