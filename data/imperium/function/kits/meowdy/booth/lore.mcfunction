# Quin Meowdy — hidden lore. Triggered by sneak-clicking the booth stand.
# Paste the fighter's lore into the body line(s) below; keep the gold color formatting.
tellraw @s \
[   "",\
    {   text:"\n  "},\
    {color:"gold",bold:true,\
        text:"Quin Meowdy - The Gunslinging Cowcat"},\
    {bold:false,\
        text:"\n\n"},\
    {color:"yellow",italic:true,\
        text:" As the great bounty hunter Smokey Bat searched for a worthy protege, he \
        settled on a candidate no one would expect: his talking cat. He was more than \
        capable with his agility and reflexes, even picking up new skills quickly...\
        but that's mostly because the local saloon always had snacks to sneak.\n"}\
]

# Sticker 2 (Historian): record this fighter's lore as read, then check for all seven.
tag @s add im.lore_meowdy
function imperium:booth/check_lore
