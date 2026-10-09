# Summon the CLEAR-kit interaction (no stand model — builder adds signage).
# Summit Interactions API: on_right_click runs clear/click as the clicker (execute on target).
summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["im.owned","im.booth_stand","im.booth_clear"]\
}
