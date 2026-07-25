# Rastus the Duelist — hidden lore. Triggered by sneak-clicking the booth stand.
# Paste the fighter's lore into the body line(s) below; keep the blue color formatting.
tellraw @s \
[   "",\
    {   text:"\n  "},\
    {color:"blue",bold:true,\
        text:"Rastus - The Lightning Duelist"},\
    {bold:false,\
        text:"\n\n"},\
    {color:"blue",italic:true,\
        text:" This kid has a one track mind on becoming the world's greatest duelist. \
        From a young age, he's been molded into a perfect fencer, optimizing \
        his movements and drilling his tactics for hours per day. Once, a \
        ferocious, two-legged metal monster wielding a Montante prodded into \
        his hidden dojo to kill him; Rastus disarmed it, chained it to the floor, \
        and gave it a saber and used it for training.\n"}\
]

# Sticker 2 (Historian): record this fighter's lore as read, then check for all seven.
tag @s add im.lore_rastus
function imperium:booth/check_lore
