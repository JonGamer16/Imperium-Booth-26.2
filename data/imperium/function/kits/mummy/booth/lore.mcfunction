# Warforged Mummy — hidden lore. Triggered by sneak-clicking the booth stand.
# Paste the fighter's lore into the body line(s) below; keep the blue color formatting.
tellraw @s \
[   "",\
    {   text:"\n  "},\
    {color:"aqua",bold:true,\
        text:"The Warforged Mummy"},\
    {bold:false,\
        text:"\n\n"},\
    {color:"yellow",italic:true,\
        text:" With its steel plates and wrapped-up helmet, a mummy is the only thing \
        people can describe it as. It's only known by word of mouth, and it's never \
        spotted in the same place twice. It might show up in towns, in a siege, or \
        in places which it shouldn't know exist. It holds a claw and a huge sword, \
        which it uses to grab and pull in a target from a distance and then attack \
        with the precision of a fully trained knight.\n"}\
]

# Sticker 2 (Historian): record this fighter's lore as read, then check for all seven.
tag @s add im.lore_mummy
function imperium:booth/check_lore
