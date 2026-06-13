# Blocked leap (airborne while ground-only is on): give the feather back and buzz.
# Shared function, so refund the kit-correct feather by tag. loot give (not replace,
# which is broken for empty slots in 26.1) drops it into the first open slot.
execute if entity @s[tag=im.kit_livvy] run loot give @s loot imperium:livvy/feather
execute if entity @s[tag=im.kit_meowdy] run loot give @s loot imperium:meowdy/feather

playsound minecraft:block.note_block.bass master @s ~ ~ ~ 0.7 0.6
