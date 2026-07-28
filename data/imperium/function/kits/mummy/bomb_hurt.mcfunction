# Macro {outer, dmg} — one ring of blast damage (runs as/at the bomb). Hurt every not-yet-hit
# humanoid (#imperium:human: players, mannequins, husks) within `outer` blocks — the blast affects
# humanoids only, so mobs, the bomb crystal, and non-combatant entities are never touched. Spare the
# placer (im_bombId == #thisBomb). Then tag everyone in range so the next (larger) ring only adds the
# new shell, never double-hitting.
$execute as @e[type=#imperium:human,distance=..$(outer),tag=!im.bomb_hit] unless score @s im_bombId = #thisBomb im_bombId run damage @s $(dmg) imperium:bomb
$tag @e[type=#imperium:human,distance=..$(outer)] add im.bomb_hit
