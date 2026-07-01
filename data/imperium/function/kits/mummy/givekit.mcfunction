#   Warforged Mummy

function imperium:util/clear_kit

#   [ARMOR]
#   Helmet - item_model="minecraft:player_head" is redundant (explicit default); swap to "minecraft:netherite_helmet" to revert appearance
item replace entity @s armor.head with \
    player_head[\
        attribute_modifiers=[\
            {type:"armor",amount:15,operation:"add_value",slot:head,id:"head"},\
            {type:"armor_toughness",amount:8,operation:"add_value",slot:head,id:"head"},\
        ],\
        enchantments={"imperium:wip_barrier":1,"protection":8},\
        !max_damage,\
        profile="Mummy",\
        item_model="minecraft:player_head",\
        custom_name={text:"Mummy Head",color:blue,italic:false},\
        custom_data={"imperium_kit":1b}\
    ] 1
item replace entity @s armor.chest with \
    netherite_chestplate[\
        !attribute_modifiers,\
        !max_damage,\
        item_model="minecraft:netherite_chestplate",\
        equippable={slot:chest,asset_id:"minecraft:netherite"},\
        trim={material:"quartz",pattern:"silence"},\
        custom_name={text:"Mummy Chestplate",color:blue,italic:false},\
        custom_data={"imperium_kit":1b}\
    ] 1
item replace entity @s armor.legs with \
    netherite_leggings[\
        !attribute_modifiers,\
        !max_damage,\
        item_model="minecraft:netherite_leggings",\
        equippable={slot:legs,asset_id:"minecraft:netherite"},\
        trim={material:"quartz",pattern:"rib"},\
        custom_name={text:"Mummy Leggings",color:blue,italic:false},\
        custom_data={"imperium_kit":1b}\
    ] 1
item replace entity @s armor.feet with \
    netherite_boots[\
        !attribute_modifiers,\
        !max_damage,\
        item_model="minecraft:netherite_boots",\
        equippable={slot:feet,asset_id:"minecraft:netherite"},\
        trim={material:"quartz",pattern:"rib"},\
        custom_name={text:"Mummy Boots",color:blue,italic:false},\
        custom_data={"imperium_kit":1b}\
    ] 1

#   [MELEE] Netherite Claymore
#       7 | 1.2
item replace entity @s hotbar.0 with \
    mace[\
        attribute_modifiers=[\
            {type:"attack_damage",amount:6,operation:add_value,slot:mainhand,id:"base_attack_damage"},\
            {type:"attack_speed",amount:-2.8,operation:add_value,slot:mainhand,id:"base_attack_speed"}\
        ],\
        enchantments={"imperium:wip_golem_throw":1},\
        !max_damage,\
        item_model="minecraft:netherite_sword",\
        custom_name={text:"Dark Claymore",color:gray,italic:false},\
        custom_data={"imperium_kit":1b},\
    ] 1

#   [SLOT 1] Grappling Hook
#item replace entity @s hotbar.1 with \
#    fishing_rod[\
#        enchantments={"imperium:wip_reeling":1},\
#        max_damage=10,\
#        custom_data={"imperium_kit":1b},\
#    ]
function imperium:kits/mummy/cd1_rod

#   [SLOT 2] [Empty]

#   [SLOT 3] [Empty]

#   [HEALING] Energy Crystal
#       10 x 8 HP, Regeneration 5|2s,
#give @s end_crystal[\
#        !can_place_on,\
#        custom_name="Energy Crystal",\
#        max_stack_size=1,\
#        food={nutrition:0,saturation:0,can_always_eat:true},\
#        consumable={\
#            consume_seconds:0,\
#            on_consume_effects:[{type:"apply_effects",effects:[\
#                {id:"instant_health",amplifier:1,duration:1s},\
#                {id:"regeneration",amplifier:4,duration:2s}]}]},\
#            use_remainder={"id":"bowl",count:1},\
#        custom_data={"imperium_healing":1b}\
#    ] 10
loot give @s loot imperium:mummy/healing

#   Ability Cooldowns
scoreboard players operation @s im_abilityCdA = #Mummy im_abilityCdA
scoreboard players operation @s im_abilityCdB = #Mummy im_abilityCdB
scoreboard players operation @s im_abilityCdC = #Mummy im_abilityCdC

#   Energy meter (see kits/mummy/energy_*) — start full, capped at #MummyEnergyMax.
scoreboard players operation @s im_energy = #MummyEnergyStart im.param

tag @s add im.kit_mummy