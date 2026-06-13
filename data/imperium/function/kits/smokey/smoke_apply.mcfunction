# Runs each tick as an active Smoke Bomb cloud, at its position.
# Only Smokey players inside the cloud gain invis + speed II.
# Re-applied every tick at 1s duration so it fades within a second of leaving.
effect give @a[tag=im.kit_smokey,distance=..3] minecraft:invisibility 2 0 true
effect give @a[tag=im.kit_smokey,distance=..3] minecraft:speed 2 1 true
