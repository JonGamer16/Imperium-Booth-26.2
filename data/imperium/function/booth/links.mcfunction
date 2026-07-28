# Link interactions — GitHub + Discord, via the Summit Interactions API (Handbook §Interactions API).
# On right-click, `execute on target` runs the tellraw AS the clicking player (@s), printing a
# clickable chat link. NOTE: vanilla can't auto-open a browser from an entity click; the click_event
# open_url only works on chat text, so this is the intended "clickable link" behaviour.
#
# PLACEMENT: an interaction's position is the CENTER of its BOTTOM face; the box extends up by
# `height` and +-`width`/2 horizontally. Each line summons at ~ ~ ~, so run this positioned at each
# spot (or edit ~ ~ ~ to absolute coords). The four overlap if run once at one point.
#
# FILL IN: replace PASTE_GITHUB_URL_HERE and PASTE_DISCORD_INVITE_HERE with your real links.

#   Pair 1 — small signage, covers a 1.1 x 1.8 x 1.1 area (width 1.1, height 1.8)
summon minecraft:interaction ~ ~ ~ {\
    width:1.1f,height:1.8f,response:1b,\
    Tags:["summit.booth_entity.imperium", "summit.interactable","summit.static","im.link"],data:{summit_interactable:{\
        on_right_click:"execute on target run tellraw @s \
            [{\"text\":\"[Imperium] \",\"color\":\"gold\"},{\"text\":\"Github Repository: https://github.com/JonGamer16/Imperium-Mundi-Data-Pack\",\"color\":\"aqua\",\"underlined\":true,\"click_event\":{\"action\":\"open_url\",\"url\":\"https://github.com/JonGamer16/Imperium-Mundi-Data-Pack\"}}]"}}}
summon minecraft:interaction ~ ~ ~ {\
    width:1.1f,height:1.8f,response:1b,\
    Tags:["summit.booth_entity.imperium", "summit.interactable","summit.static","im.link"],data:{summit_interactable:{\
        on_right_click:"execute on target run tellraw @s \
            [{\"text\":\"[Imperium] \",\"color\":\"gold\"},{\"text\":\"Discord Server: https://discord.gg/kXyqnskP2x\",\"color\":\"blue\",\"underlined\":true,\"click_event\":{\"action\":\"open_url\",\"url\":\"https://discord.gg/kXyqnskP2x\"}}]"}}}

#   Pair 2 — large signage, covers a 2 x 3 x 2 area (width 2, height 3)
summon minecraft:interaction ~ ~ ~ {\
    width:2.0f,height:3.0f,response:1b,\
    Tags:["summit.booth_entity.imperium", "summit.interactable","summit.static","im.link"],data:{summit_interactable:{\
        on_right_click:"execute on target run tellraw @s \
            [{\"text\":\"[Imperium] \",\"color\":\"gold\"},{\"text\":\"Github Repository: https://github.com/JonGamer16/Imperium-Mundi-Data-Pack\",\"color\":\"aqua\",\"underlined\":true,\"click_event\":{\"action\":\"open_url\",\"url\":\"https://github.com/JonGamer16/Imperium-Mundi-Data-Pack\"}}]"}}}
summon minecraft:interaction ~ ~ ~ {\
    width:2.0f,height:3.0f,response:1b,\
    Tags:["summit.booth_entity.imperium", "summit.interactable","summit.static","im.link"],data:{summit_interactable:{\
        on_right_click:"execute on target run tellraw @s \
            [{\"text\":\"[Imperium] \",\"color\":\"gold\"},{\"text\":\"Discord Server: https://discord.gg/kXyqnskP2x\",\"color\":\"blue\",\"underlined\":true,\"click_event\":{\"action\":\"open_url\",\"url\":\"https://discord.gg/kXyqnskP2x\"}}]"}}}
