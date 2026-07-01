# Macro {outer, dmg} — one ring of blast damage (runs as/at the bomb). Hurt every not-yet-hit valid
# target within `outer` blocks: mobs + players/mannequins, excluding non-combatants (#im.not_mob:
# items, projectiles, armor_stands, markers…) and the bomb crystal itself. Spare the placer
# (im_bombId == #thisBomb). Then tag everyone in range so the next (larger) ring only adds the new
# shell, never double-hitting.
$execute as @e[type=!#minecraft:im.not_mob,type=!minecraft:end_crystal,distance=..$(outer),tag=!im.bomb_hit] unless score @s im_bombId = #thisBomb im_bombId run damage @s $(dmg) imperium:bomb
$tag @e[type=!#minecraft:im.not_mob,type=!minecraft:end_crystal,distance=..$(outer)] add im.bomb_hit
