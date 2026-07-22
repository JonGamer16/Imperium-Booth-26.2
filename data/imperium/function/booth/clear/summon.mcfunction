# Summon the CLEAR-kit interaction (no stand model — builder adds signage).
# Summit Interactions API: on_right_click runs clear/click as the clicker (execute on target).
summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["summit.interactable","summit.static","im.booth_stand","im.booth_clear"],\
    data:{summit_interactable:{on_right_click:"execute on target run function imperium:booth/clear/click"}}\
}
