# Charge Attack armed — Levent went #LeventCharge ticks without attacking or raising his shield.
# Boost the NEXT hit via PLAYER attribute modifiers (not the item, so the attack-strength cooldown
# isn't reset). charge_off / clear_kit strip these back off after the hit (or on a kit swap).
#   >> TUNING KNOBS (kept inline — `attribute … add` needs a literal value, not a score):
#      attack_damage burst, reach in blocks (3.0 base -> 4.5), knockback on top of the rod. <<
tag @s add im.levent_charged
attribute @s minecraft:attack_damage modifier add imperium:charge 2 add_value
attribute @s minecraft:entity_interaction_range modifier add imperium:charge 1 add_value
attribute @s minecraft:attack_knockback modifier add imperium:charge 0.5 add_value

title @s actionbar {text:"⦿ Focus ready",color:"light_purple"}
