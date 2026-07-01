# Run as the owner of a still-live bobber. Mark live (so reel-in detection knows the bobber still
# exists); arm if the bobber is hooked into something, else disarm so a stale hook can't fire.
tag @s add im.mgrapple_live
execute if score #hooked im_grappleId matches 1 run tag @s add im.mgrapple_armed
execute unless score #hooked im_grappleId matches 1 run tag @s remove im.mgrapple_armed
