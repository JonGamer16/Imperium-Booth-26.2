# Strip the Charge Attack boost (spent on a hit, or interrupted by a shield raise). Mirror of
# charge_on. The loop calls this the tick after im_leventCharge drops below #LeventCharge.
tag @s remove im.levent_charged
attribute @s minecraft:attack_damage modifier remove imperium:charge
attribute @s minecraft:entity_interaction_range modifier remove imperium:charge
attribute @s minecraft:attack_knockback modifier remove imperium:charge

title @s actionbar {text:"⦿ Focus ready",color:"dark_gray"}
