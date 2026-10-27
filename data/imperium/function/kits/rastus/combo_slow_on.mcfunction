# Out of dashes: slow the rapier. A PLAYER attribute modifier, like focus_on — no item edit, so the
# attack-strength cooldown isn't reset. add_multiplied_total -0.75 scales the final value:
# base 4 + rapier 4 = 8 attacks/s -> 2 (2.25 while the Strike's +1 is armed).
# Edge-triggered from loop_kit (im.rastus_slowed), so it runs once per empty spell, not per tick.
#   >> TUNING KNOB: the -0.75 below (inline: `attribute … add` needs a literal). <<
tag @s add im.rastus_slowed
attribute @s minecraft:attack_speed modifier add imperium:combo_slow -0.75 add_multiplied_total
