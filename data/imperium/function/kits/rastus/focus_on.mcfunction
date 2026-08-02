# Strike armed — the shared charge (im_melee_drought) just reached #StrikeCharge. Boost the
# rapier's bite via PLAYER attribute modifiers (no item edit, so the attack-strength cooldown
# isn't reset). focus_off / reset_focus strip these back off.
#   >> TUNING KNOBS: the three amounts below (kept inline because `attribute … add` needs a
#      literal value, not a score). attack_knockback +3 overcomes the rapier's -1 base. <<
tag @s add im.rastus_focused
attribute @s minecraft:attack_damage modifier add imperium:focus 5 add_value
attribute @s minecraft:attack_speed modifier add imperium:focus 1 add_value
attribute @s minecraft:attack_knockback modifier add imperium:focus 1 add_value
attribute @s minecraft:entity_interaction_range modifier add imperium:focus 0.5 add_value

# Armed feedback — this charge powers BOTH the Strike (next hit) and the Parry (shield raise).
# Audio only, deliberately: the actionbar belongs to the Air Dodge stock readout (rastus/dash_count),
# and two writers would just overwrite each other. Fires once per charge (the im.rastus_focused tag
# gates loop_kit's call), so it can't turn into a per-tick ding.
playsound minecraft:entity.experience_orb.pickup player @s ~ ~ ~ 0.4 1.5
