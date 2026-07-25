# Ensure exactly ONE training dummy: a mummy-armored husk guests can spar with (booth players carry
# summit.no_regen, so its hits land and healing items get real practice). Regeneration 10 (hidden)
# tops it up between visitors; the 5t loop tethers it to its im.dummy_home marker. follow_range 4
# keeps it from wandering after players. summit.dynamic: it moves and takes damage, so it's summoned
# via #entities/summon and must never ride the schematic.
#
# Spawns on the im.dummy_home marker NEAREST the canonical spot (-138.5 75 -221) — the ONE place
# that coord lives — so a stray extra marker never pulls it off-station. Kills any existing dummy
# husk first, so this is idempotent: the manual "spawn" command, the #entities/summon hook, and the
# interaction toggle all converge on a single husk. No marker within reach -> nothing spawns.
kill @e[type=husk,tag=im.dummy]

execute positioned -138.5 75.0 -221.0 as @n[type=marker,tag=im.dummy_home] run summon minecraft:husk ~ ~ ~ \
    {   Tags:["im.dummy","im.dummy_new","summit.booth_entity.imperium","summit.dynamic"],\
        PersistenceRequired:1b,\
        CanPickUpLoot:0b,\
        CustomName:{text:"Training Dummy",color:"gold",italic:false},\
        CustomNameVisible:1b,\
        drop_chances:{mainhand:0.0f,head:0.0f,chest:0.0f,legs:0.0f,feet:0.0f},\
        attributes:[{id:"minecraft:spawn_reinforcements",base:0.0},{id:"minecraft:follow_range",base:4.0}]\
    }

# Real Mummy sword + armor (same defs as kits/mummy/givekit) but with the imperium_kit custom_data
# stripped and no im.kit_mummy tag, so the booth never scans/ticks it for abilities. All targeted by
# the im.dummy_new tag, so no per-piece positioning is needed.
item replace entity @e[type=husk,tag=im.dummy_new,limit=1] armor.head with \
    player_head[\
        attribute_modifiers=[\
            {type:"armor",amount:15,operation:"add_value",slot:head,id:"head"},\
            {type:"armor_toughness",amount:8,operation:"add_value",slot:head,id:"head"},\
            {type:"attack_knockback",amount:1,operation:"add_value",slot:"head",id:"head"},\
            {type:"knockback_resistance",amount:0.44,operation:"add_value",slot:"head",id:"head"},\
        ],\
        enchantments={"imperium:wip_barrier":1,"protection":8},\
        !max_damage,\
        profile="Mummy",\
        item_model="minecraft:player_head",\
        custom_name={text:"Mummy Head",color:blue,italic:false}\
    ] 1
item replace entity @e[type=husk,tag=im.dummy_new,limit=1] armor.chest with \
    netherite_chestplate[\
        !attribute_modifiers,\
        !max_damage,\
        item_model="minecraft:netherite_chestplate",\
        equippable={slot:chest,asset_id:"minecraft:netherite"},\
        trim={material:"quartz",pattern:"silence"},\
        custom_name={text:"Mummy Chestplate",color:blue,italic:false}\
    ] 1
item replace entity @e[type=husk,tag=im.dummy_new,limit=1] armor.legs with \
    netherite_leggings[\
        !attribute_modifiers,\
        !max_damage,\
        item_model="minecraft:netherite_leggings",\
        equippable={slot:legs,asset_id:"minecraft:netherite"},\
        trim={material:"quartz",pattern:"rib"},\
        custom_name={text:"Mummy Leggings",color:blue,italic:false}\
    ] 1
item replace entity @e[type=husk,tag=im.dummy_new,limit=1] armor.feet with \
    netherite_boots[\
        !attribute_modifiers,\
        !max_damage,\
        item_model="minecraft:netherite_boots",\
        equippable={slot:feet,asset_id:"minecraft:netherite"},\
        trim={material:"quartz",pattern:"rib"},\
        custom_name={text:"Mummy Boots",color:blue,italic:false}\
    ] 1
item replace entity @e[type=husk,tag=im.dummy_new,limit=1] weapon.mainhand with \
    mace[\
        attribute_modifiers=[\
            {type:"attack_damage",amount:6,operation:add_value,slot:mainhand,id:"base_attack_damage"},\
            {type:"attack_speed",amount:-2.8,operation:add_value,slot:mainhand,id:"base_attack_speed"}\
        ],\
        enchantments={"imperium:wip_golem_throw":1,"imperium:mace_smash":1},\
        !max_damage,\
        item_model="minecraft:netherite_sword",\
        custom_name={text:"Dark Claymore",color:dark_gray,italic:false}\
    ] 1

effect give @e[type=husk,tag=im.dummy_new,limit=1] minecraft:regeneration infinite 9 true

tag @e[type=husk,tag=im.dummy_new] remove im.dummy_new
