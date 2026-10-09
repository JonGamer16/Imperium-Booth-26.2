# Summon the RANDOM-kit selection interaction (no stand model — builder adds signage).
# Summit Interactions API: on_right_click runs random/click as the clicker (execute on target).
# Run once where you want it (setup_stands places one in the test row).
summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["im.owned","im.booth_stand","im.booth_random"]\
}
