# Re-assert the player's saved kit choice at match entry (called from the player_enter
# hook while our booth is active — assign_kit only sticks then). 0/unset = no call, so
# register_booth's default (Cliffshield) applies.
execute if score @s im_lastKit matches 1 run function imperium:kits/cliffshield/booth/assign
execute if score @s im_lastKit matches 2 run function imperium:kits/meowdy/booth/assign
execute if score @s im_lastKit matches 3 run function imperium:kits/livvy/booth/assign
execute if score @s im_lastKit matches 4 run function imperium:kits/mummy/booth/assign
execute if score @s im_lastKit matches 5 run function imperium:kits/levent/booth/assign
execute if score @s im_lastKit matches 6 run function imperium:kits/rastus/booth/assign
execute if score @s im_lastKit matches 7 run function imperium:kits/smokey/booth/assign
