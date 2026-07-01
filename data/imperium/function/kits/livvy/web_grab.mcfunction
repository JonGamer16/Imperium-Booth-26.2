# Caught in a web (runs as the victim) — clamp movement and pile on air drag so they're stuck in
# place like a cobweb, without an actual block. web_release / clear_kit strip these back off once
# the victim leaves every web (or swaps kit).
#   >> TUNING KNOBS (kept inline — `attribute … add` needs a literal value, not a score):
#      movement_speed -50%, air_drag +9. <<
tag @s add im.webbed
attribute @s minecraft:movement_speed modifier add imperium:web -0.5 add_multiplied_base
attribute @s minecraft:air_drag_modifier modifier add imperium:web 9 add_value
