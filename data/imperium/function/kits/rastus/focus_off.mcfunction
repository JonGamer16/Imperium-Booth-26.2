# Strip the Strike boost (charge spent, or it drained without a hit). Mirror of focus_on.
tag @s remove im.rastus_focused
attribute @s minecraft:attack_damage modifier remove imperium:focus
attribute @s minecraft:attack_speed modifier remove imperium:focus
attribute @s minecraft:attack_knockback modifier remove imperium:focus

# Unarmed feedback — this charge powers BOTH the Strike (next hit) and the Parry (shield raise).
title @s actionbar {text:"⦿ Focus ready",color:"dark_gray"}
