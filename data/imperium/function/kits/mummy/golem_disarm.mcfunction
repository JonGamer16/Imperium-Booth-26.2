# Golem Throw window closed without a hit (or the charge was lost — energy dipped, or sneak released
# mid-window). Drop the armed state with a soft fizzle so the Mummy and nearby enemies both register
# that the threat has passed. The wind-up keeps cycling (the loop already reset the charge on expiry /
# sneak release). NOT called on a successful throw — golem_after removes im.golem_armed itself.
tag @s remove im.golem_armed
playsound minecraft:block.fire.extinguish player @a[distance=..16] ~ ~ ~ 0.5 1.2
