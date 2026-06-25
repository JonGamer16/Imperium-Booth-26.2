# Smokey Bat — booth selection. Runs as the clicking player (routed from
# the kit's booth/click handler). Equips the kit via the arena pipeline, then describes it.
scoreboard players set @s givekit 7
function imperium:arena/givekit

tellraw @s \
[   "",\
    {           text:"\n  "},\
    {color:"gold",bold:true,\
                text:"Smokey Bat - The Blind Assassin \n\n"},\
    {color:"gold",\
                text:"  • [Melee] ",},\
    {color:"gold",\
                text:"Steel Dagger",},\
    {color:"gray",\
                text:" — + Attack Speed; + Critical Damage; Backstabs deal increased damage\n",},\
    {color:"gold",\
                text:"  • [Melee] ",},\
    {color:"gold",\
                text:"Sweeping Hatchet",},\
    {color:"gray",\
                text:" — Can be used in the offhand; Right-click and drag to attack enemies in an arc\n",},\
    {color:"gold",\
                text:"  • [Special] ",},\
    {color:"gold",\
                text:"Grappling Rod",},\
    {color:"gray",\
                text:" — Launch yourself towards the hook\n",},\
    {color:"gold",\
                text:"  • [Consumable] ",},\
    {color:"gold",\
                text:"Marking Dart",},\
    {color:"gray",\
                text:" — Marks the target, powering up your melee attacks\n",},\
    {color:"gold",\
                text:"  • [Consumable] ",},\
    {color:"gold",\
                text:"Smoke Bomb",},\
    {color:"gray",\
                text:" — Obscures just the enemy's view, and gives you Speed 2 + Invisibility in its area\n",},\
    {color:"gold",\
                text:"  • [Healing] ",},\
    {color:"gold",\
                text:"Rabbit Stew x10",},\
    {color:"gray",\
                text:" — Heals 12 HP\n",}]

playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.7 1.4
title @s actionbar {text:"Smokey Bat selected",color:"gold"}
