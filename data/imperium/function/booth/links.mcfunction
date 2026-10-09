# Link signage — GitHub + Discord interaction hitboxes.
#
# WAS the Summit Interactions API: each interaction carried summit.interactable plus a
# data:{summit_interactable:{on_right_click:"..."}} payload holding the whole tellraw inline. That
# API does not exist standalone, so the click is advancement-driven now, exactly like the kit stands:
#     right-click  ->  imperium:booth/link_{github,discord}  (entity condition: the im.link_* tag)
#                  ->  reward function, which already runs as the clicking player
# The reward functions hold the message, so editing the link text no longer means editing escaped
# JSON nested inside an NBT string inside a summon.
#
# The four signs used to share ONE im.link tag, which was fine when each carried its own payload but
# makes them indistinguishable to an advancement. They are split by destination now.
#
# PLACEMENT: an interaction's position is the CENTER of its BOTTOM face; the box extends up by
# `height` and ±`width`/2 horizontally. Each line summons at ~ ~ ~, so run this positioned at each
# spot — all four overlap if you run it once at one point.

#   Pair 1 — small signage, covers a 1.1 x 1.8 x 1.1 area
summon minecraft:interaction ~ ~ ~ \
{   width:1.1f,height:1.8f,response:1b,\
    Tags:["im.owned","im.link","im.link_github"]\
}
summon minecraft:interaction ~ ~ ~ \
{   width:1.1f,height:1.8f,response:1b,\
    Tags:["im.owned","im.link","im.link_discord"]\
}

#   Pair 2 — large signage, covers a 2 x 3 x 2 area
summon minecraft:interaction ~ ~ ~ \
{   width:2.0f,height:3.0f,response:1b,\
    Tags:["im.owned","im.link","im.link_github"]\
}
summon minecraft:interaction ~ ~ ~ \
{   width:2.0f,height:3.0f,response:1b,\
    Tags:["im.owned","im.link","im.link_discord"]\
}
