# Lower the Energy Barrier: remove the max_absorption cap and clear the hearts. Energy is already
#   current (the hold sync mirrored every hit into it), so dropping the hearts banks the leftover.
tag @s remove im.barrier_up
attribute @s minecraft:max_absorption modifier remove imperium:barrier
playsound block.conduit.deactivate player @s ~ ~ ~ 0.2 2