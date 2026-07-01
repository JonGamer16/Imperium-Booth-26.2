# Golem Throw armed — one-shot cue the tick the wind-up completes (im_golemReady flips 1). Heard by
# nearby players too (it's a telegraph), paired with the per-tick crit particles in the loop. No
# actionbar cue: the per-tick energy HUD owns the action bar and would overwrite it instantly.
tag @s add im.golem_armed
playsound minecraft:block.respawn_anchor.charge player @a[distance=..16] ~ ~ ~ 1 0.8
