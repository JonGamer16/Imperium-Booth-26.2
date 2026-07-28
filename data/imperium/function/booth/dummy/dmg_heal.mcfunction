# Between-flurries top-up (runs AS the husk). No constant regen, so this only ever fires on quiet
# ticks and never overlaps a hit. Clamps to max_health (200). Re-arm the no-hit counter so the
# next check is another 2s out.
data merge entity @s {Health:200.0f}
scoreboard players set @s im_dmgLull 0
