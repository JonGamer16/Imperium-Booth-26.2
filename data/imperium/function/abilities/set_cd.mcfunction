# Configure one ability slot's cooldown. Macro args:
#   kit   - fake-player name, e.g. "Livvy"
#   slot  - "A" | "B" | "C"
#   base  - cooldown length in damage units; 0 = use the global default
#   stock - stockpile %% (0-100): how much of the cd may pre-charge while frozen;
#           -1 = use the global default
# Sets #<kit> im_abilityCd<slot>, im_cdStock<slot>, and the derived im_cdFloor<slot>.
# Floor = base * (100 - stock) / 100 (min 1) = the value a frozen slot bleeds down to.

# Resolve base (0 -> global default in #GlobalDefault im.dmg)
$scoreboard players set #b im.temp $(base)
execute if score #b im.temp matches 0 run scoreboard players operation #b im.temp = #GlobalDefault im.dmg
# Resolve stock (-1 -> global default in #GlobalStock im.dmg)
$scoreboard players set #s im.temp $(stock)
execute if score #s im.temp matches -1 run scoreboard players operation #s im.temp = #GlobalStock im.dmg

# Store base and stock
$scoreboard players operation #$(kit) im_abilityCd$(slot) = #b im.temp
$scoreboard players operation #$(kit) im_cdStock$(slot) = #s im.temp

# floor = base * (100 - stock) / 100, clamped to >= 1 so a frozen slot never hits 0
scoreboard players set #f im.temp 100
scoreboard players operation #f im.temp -= #s im.temp
scoreboard players operation #f im.temp *= #b im.temp
scoreboard players operation #f im.temp /= const 100
scoreboard players operation #f im.temp > const 1
$scoreboard players operation #$(kit) im_cdFloor$(slot) = #f im.temp
