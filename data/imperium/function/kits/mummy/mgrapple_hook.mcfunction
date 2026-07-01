# Run as the entity sitting in the bobber (#bid = the bobber's id, set in mgrapple_scan). Become
# this bobber's hooked target: carry its id so the reel can find me, tag me, and tell the owner a
# hook exists. Re-runs each tick the bobber stays on me, so it just refreshes (idempotent).
scoreboard players operation @s im_grappleId = #bid im_grappleId
tag @s add im.mgrapple_hooked
scoreboard players set #hooked im_grappleId 1
