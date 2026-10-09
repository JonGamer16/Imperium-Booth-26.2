# Manual one-time placement — stand where players should click and run this. Drops a static
# (schematic-saved) interaction that toggles the dummy on right-click: summon if gone, dismiss if
# up. response:1b so the click registers; summit.static so it rides the schematic.
summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["im.owned","im.dummy_toggle"]\
}
