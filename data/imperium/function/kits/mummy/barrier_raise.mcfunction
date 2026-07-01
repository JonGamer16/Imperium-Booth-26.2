# Raise the Energy Barrier: snapshot the current energy onto the absorption hearts. The projection +
# the /data-can't-touch-players workaround live in barrier_apply / barrier_macro.
tag @s add im.barrier_up
function imperium:kits/mummy/barrier_apply
playsound block.enchantment_table.use player @s ~ ~ ~ 0.6 1.7
