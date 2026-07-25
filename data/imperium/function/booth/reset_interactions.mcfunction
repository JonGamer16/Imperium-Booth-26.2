# One-shot: (re)build a test row of all seven kit-selection stands.
# Clears any existing booth stands first so re-running never duplicates them, then
# places the seven kits spaced 3 blocks apart along +X starting at your feet.
kill @e[type=interaction,tag=im.booth_stand,limit=9]

execute positioned ~ ~ ~ run summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["summit.interactable","summit.static","im.booth_stand","im.booth_cliffshield"],\
    data:{summit_interactable:{on_right_click:"execute on target run function imperium:kits/cliffshield/booth/click"}}\
}
execute positioned ~ ~ ~-3 run summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["summit.interactable","summit.static","im.booth_stand","im.booth_rastus"],\
    data:{summit_interactable:{on_right_click:"execute on target run function imperium:kits/rastus/booth/click"}}\
}
execute positioned ~ ~ ~-6 run summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["summit.interactable","summit.static","im.booth_stand","im.booth_livvy"],\
    data:{summit_interactable:{on_right_click:"execute on target run function imperium:kits/livvy/booth/click"}}\
}
execute positioned ~ ~ ~-9 run summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["summit.interactable","summit.static","im.booth_stand","im.booth_mummy"],\
    data:{summit_interactable:{on_right_click:"execute on target run function imperium:kits/mummy/booth/click"}}\
}
execute positioned ~2 ~ ~-11 run summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["summit.interactable","summit.static","im.booth_stand","im.booth_levent"],\
    data:{summit_interactable:{on_right_click:"execute on target run function imperium:kits/levent/booth/click"}}\
}
execute positioned ~5 ~ ~-11 run summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["summit.interactable","summit.static","im.booth_stand","im.booth_smokey"],\
    data:{summit_interactable:{on_right_click:"execute on target run function imperium:kits/smokey/booth/click"}}\
}
execute positioned ~8 ~ ~-11 run summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["summit.interactable","summit.static","im.booth_stand","im.booth_meowdy"],\
    data:{summit_interactable:{on_right_click:"execute on target run function imperium:kits/meowdy/booth/click"}}\
}


# Utility stands: random kit + clear kit (interactions only, no display model)
execute positioned ~4.75 ~-0.625 ~2.5 run function imperium:booth/random/summon
execute positioned ~6.5 ~-0.625 ~-5.25 run function imperium:booth/clear/summon
