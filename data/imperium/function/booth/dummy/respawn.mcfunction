# Summon the training dummy itself: a mummy-armored husk guests can spar with (booth
# players carry summit.no_regen, so its hits land and healing items get real practice).
# Regeneration 10 keeps it topped up between visitors; the 5t loop tethers it to its
# im.dummy_home marker and kills it near the booth edge (then auto-respawns it at home).
# summit.dynamic: it moves and takes damage, so it must never ride the schematic.
summon minecraft:husk ~ ~ ~ \
{   Tags:["im.dummy","im.dummy_new","summit.booth_entity.imperium","summit.dynamic"],\
    PersistenceRequired:1b,\
    CanPickUpLoot:0b,\
    CustomName:{text:"Training Dummy",color:"gold",italic:false},\
    CustomNameVisible:1b,\
    drop_chances:{head:0.0f,chest:0.0f,legs:0.0f,feet:0.0f},\
    attributes:[{id:"minecraft:spawn_reinforcements",base:0.0}]\
}

# Mummy armor from the display-stand loot tables (same look as the selection stand).
loot replace entity @e[type=husk,tag=im.dummy_new,limit=1] armor.head loot imperium:mummy/display/head
loot replace entity @e[type=husk,tag=im.dummy_new,limit=1] armor.chest loot imperium:mummy/display/chest
loot replace entity @e[type=husk,tag=im.dummy_new,limit=1] armor.legs loot imperium:mummy/display/legs
loot replace entity @e[type=husk,tag=im.dummy_new,limit=1] armor.feet loot imperium:mummy/display/feet

effect give @e[type=husk,tag=im.dummy_new,limit=1] minecraft:regeneration infinite 9 true

tag @e[type=husk,tag=im.dummy_new] remove im.dummy_new
