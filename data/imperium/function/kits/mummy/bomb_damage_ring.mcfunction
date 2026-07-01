# One ring of the blast falloff, recursing outward (runs as the bomb, at the bomb). #bombRing is the
# current ring (0 = center). dmg = #BombMaxDamage - #BombDropoff*ring; stop at #BombRange or once the
# damage reaches 0. bomb_hurt damages not-yet-hit humans within this ring's outer radius and tags them,
# so each target is hit exactly once at its nearest ring.
execute if score #bombRing im.temp >= #BombRange im.param run return 0

scoreboard players operation #bombDmg im.temp = #BombMaxDamage im.param
scoreboard players operation #bombDrop im.temp = #BombDropoff im.param
scoreboard players operation #bombDrop im.temp *= #bombRing im.temp
scoreboard players operation #bombDmg im.temp -= #bombDrop im.temp
execute if score #bombDmg im.temp matches ..0 run return 0

scoreboard players operation #bombOuter im.temp = #bombRing im.temp
scoreboard players add #bombOuter im.temp 1
execute store result storage imperium:bomb outer int 1 run scoreboard players get #bombOuter im.temp
execute store result storage imperium:bomb dmg int 1 run scoreboard players get #bombDmg im.temp
function imperium:kits/mummy/bomb_hurt with storage imperium:bomb

scoreboard players add #bombRing im.temp 1
function imperium:kits/mummy/bomb_damage_ring
