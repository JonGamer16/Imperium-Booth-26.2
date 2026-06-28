# Run as the owner of a still-live bobber. Mark live (so reel-in detection knows the bobber still
# exists); arm + store the current offset if anchored, else disarm so a stale offset can't fire.
tag @s add im.grapple_live
execute if score #anchor im_grappleId matches 1 run function imperium:kits/smokey/grapple_arm
execute unless score #anchor im_grappleId matches 1 run tag @s remove im.grapple_armed
