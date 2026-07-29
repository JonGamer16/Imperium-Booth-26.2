# Strip the Strike boost (charge spent, or it drained without a hit). Mirror of focus_on.
tag @s remove im.rastus_focused
attribute @s minecraft:attack_damage modifier remove imperium:focus
attribute @s minecraft:attack_speed modifier remove imperium:focus
attribute @s minecraft:attack_knockback modifier remove imperium:focus

# No unarmed cue: focus_on's ding marks the charge landing, and the actionbar is now the Air Dodge
# stock readout (rastus/dash_count) — a "focus spent" write here would clobber the dash count.
