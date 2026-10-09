# Called at the end of each kit's booth/lore, after that kit's im.lore_<kit> tag is added.
# Fires once the player has read all seven fighters' lore.
#
# This used to grant Summit sticker 2 (Historian):
#     advancement grant @s only summit.sticker_book:imperium/read_lore
# The sticker book was generated from booth_definition.sticker_book and does not exist standalone,
# so the grant is gone. The seven im.lore_<kit> tags are NOT gone, and are worth keeping: they are
# already-collected per-player progress state, and are the obvious feed for the kit-unlock system
# (read a fighter's lore -> that fighter becomes purchasable) when persistent gold lands.
#
# im.lore_done makes the message fire exactly once rather than on every subsequent lore read.
execute if entity @s[tag=im.lore_done] run return 0
execute unless entity @s[tag=im.lore_cliffshield,tag=im.lore_levent,tag=im.lore_livvy,tag=im.lore_meowdy,tag=im.lore_mummy,tag=im.lore_rastus,tag=im.lore_smokey] run return 0

tag @s add im.lore_done
playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.6 1.6
tellraw @s [{"text":"[Imperium] ","color":"gold"},{"text":"Historian","color":"yellow","bold":true},{"text":" — you've read the lore of all seven fighters.","color":"gray"}]
