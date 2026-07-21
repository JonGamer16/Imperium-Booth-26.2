# Rastus the Duelist — booth selection. Runs as the clicking player (routed from
# the kit's booth/click handler). Equips the kit via the arena pipeline, then describes it.
scoreboard players set @s givekit 6
function imperium:arena/givekit
function imperium:kits/rastus/booth/assign

tellraw @s \
[   "",\
{                   text:"\n  "},\
    {color:"blue",bold:true,\
                    text:"Rastus - The Lightning Duelist \n\n"},\
    {color:"gold",\
                    text:"  • [Melee] "},\
    {color:"aqua",\
                    text:"Lightning Rapier"},\
    {color:"gray",\
                    text:" — Bypasses invulnerability to deal more hits per second | ⬆️ Attack Speed | ⬇️ Knockback\n",},\
    {color:"gold",\
                    text:"  • [Consumable] "},\
    {color:"aqua",\
                    text:"Buckler"},\
    {color:"gray",\
                    text:" — Blocks attacks while sprinting | ⬇️ Blocking Angle | ⬇️ Damage Blocked | ⬇️ KB Resist\n",},\
    {color:"gold",\
                    text:"  • [Special] "},\
    {color:"aqua",\
                    text:"Strike and Parry"},\
    {color:"gray",\
                    text:" — After 0.6 seconds without attacking or blocking, unleash a single-hit attack with more reach,\n"},\
    {color:"gray",\
                    text:" or fully deflect an attack by blocking it within 0.1 seconds before contact\n"},\
    {color:"gold",\
                    text:"  • [Special] "},\
    {color:"aqua",\
                    text:"Superior Agility"},\
    {color:"gray",\
                    text:" — While airborne, Crouch and press any direction to dodge in that direction\n"},\
    {color:"gold",\
                    text:"  • [Healing] "},\
    {color:"aqua",\
                    text:"Splash Healing Potion x16"},\
    {color:"gray",\
                    text:" — Heals up to 8 HP\n"},\
]

playsound minecraft:entity.player.attack.sweep neutral @s ~ ~ ~ 0.7 1.4
title @s actionbar {text:"Rastus selected",color:"blue"}
