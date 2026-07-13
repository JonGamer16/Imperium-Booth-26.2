# Summon the RANDOM-kit selection interaction (no stand model — builder adds signage).
# Same advancement-click pipeline as the seven kit stands (imperium:booth/select_random).
# Run once where you want it (setup_stands places one in the test row).
summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["im.booth_stand","im.booth_random"]\
}
