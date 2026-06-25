#   Smokey Bat

function imperium:util/clear_kit

#   [ARMOR]
item replace entity @s armor.head with \
    netherite_helmet[\
        !max_damage,\
        attribute_modifiers=[\
            {type:"armor",amount:16,operation:"add_value",slot:"head",id:"head"},\
            {type:"armor_toughness",amount:8,operation:"add_value",slot:"head",id:"head"},\
            {type:"movement_speed",amount:0.2,operation:"add_multiplied_base",slot:"head",id:"head"},\
            {type:"sneaking_speed",amount:1,operation:"add_value",slot:"head",id:"head"},\
        ],\
        item_model="minecraft:chainmail_helmet",\
        equippable={slot:head,asset_id:"minecraft:chainmail"},\
        trim={material:"netherite",pattern:"eye"},\
        custom_name={text:"Bounty Hunter Helmet",color:gold,italic:false},\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.chest with \
    netherite_chestplate[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:chainmail_chestplate",\
        equippable={slot:chest,asset_id:"minecraft:chainmail"},\
        trim={material:"iron",pattern:"silence"},\
        custom_name={text:"Bounty Hunter Chestplate",color:gold,italic:false},\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.legs with \
    netherite_leggings[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_leggings",\
        equippable={slot:legs,asset_id:"minecraft:leather"},\
        dyed_color=14464401,\
        trim={material:"netherite",pattern:"snout"},\
        custom_name={text:"Bounty Hunter Leggings",color:gold,italic:false},\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.feet with \
    netherite_boots[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_boots",\
        equippable={slot:feet,asset_id:"minecraft:leather"},\
        dyed_color=14464401,\
        trim={material:"copper",pattern:"bolt"},\
        custom_name={text:"Bounty Hunter Boots",color:gold,italic:false},\
        custom_data={"imperium_kit":1b},\
    ] 1

#   [MELEE] Steel Dagger
#       3 | 4, Crits, Backstab
item replace entity @s hotbar.0 with \
    netherite_sword[\
        attribute_modifiers=[\
            {type:"attack_damage",amount:2,operation:"add_value",slot:"mainhand",id:"base_attack_damage"},\
            {type:"attack_speed",amount:0,operation:"add_value",slot:"mainhand",id:"base_attack_speed"}\
        ],\
        enchantments={"imperium:wip_marked":1,"imperium:crits":3,"imperium:backstab":1},\
        use_effects={speed_multiplier:1},\
        !max_damage,\
        item_model="minecraft:iron_sword",\
        custom_name={text:"Steel Dagger",color:gold,italic:false},\
        swing_animation={type:"stab",duration:10},\
        custom_data={"imperium_kit":1b},\
    ] 1

#   [MELEE] Sweeping Hatchet
#       6 | 1, Breaks Shields
item replace entity @s hotbar.1 with \
    netherite_sword[\
        attribute_modifiers=[\
            {type:"attack_damage",amount:5,operation:"add_value",slot:"mainhand",id:"base_attack_damage"},\
            {type:"attack_speed",amount:-3,operation:"add_value",slot:"mainhand",id:"base_attack_speed"},\
            {type:"attack_knockback",amount:0.5,operation:"add_value",slot:"mainhand",id:"mainhand"},\
        ],\
        enchantments={"imperium:wip_marked":1},\
        weapon={\
            disable_blocking_for_seconds:4,\
            item_damage_per_attack:0},\
        kinetic_weapon={\
            delay_ticks:0,\
            contact_cooldown_ticks:10,\
            damage_multiplier:0.0f,\
            damage_conditions:{\
                max_duration_ticks:6,\
                min_speed:0,\
                min_relative_speed:0\
            },\
        },\
        use_effects={speed_multiplier:1},\
        !max_damage,\
        item_model="minecraft:stone_axe",\
        custom_name={text:"Sweeping Hatchet",color:gold,italic:false},\
        swing_animation={type:"whack",duration:6},\
        custom_data={"imperium_kit":1b},\
    ] 1

#   [SLOT 1] Grappling Rod
#item replace entity @s weapon.offhand with \
#    fishing_rod[\
#        max_damage=10,\
#        enchantments={"imperium:wip_grappling":1},\
#        custom_name={text:"Grappling Rod",color:gold,italic:false},\
#        custom_data={"imperium_kit":1b},\
#    ]
function imperium:kits/smokey/cd1_rod

#   [SLOT 2] Marking Dart
#item replace entity @s hotbar.2 with \
#    arrow[\
#        consumable={consume_seconds:0.05,has_consume_particles:false,animation:"trident"},\
#        enchantments={"imperium:single_use":1},\
#        custom_name={text:"Marking Dart",color:gold,italic:false},\
#        custom_data={"imperium_kit":1b},\
#    ]
function imperium:kits/smokey/cd2_arrow

#   [SLOT 3] Smoke Bomb
#item replace entity @s hotbar.3 with \
#    lingering_potion[\
#        potion_contents={\
#            custom_effects:[\
#                {id:"invisibility",amplifier:0,duration:20},\
#                {id:"speed",amplifier:1,duration:20}]},\
#        custom_name={text:"Smoke Bomb",color:gold,italic:false},\
#        custom_data={"imperium_kit":1b},\
#    ]
function imperium:kits/smokey/cd3_potion

#   [HEALING] Rabbit Stew
#       10 x 12 HP
#give @s \
#    rabbit_stew[\
#        food={nutrition:0,saturation:0,can_always_eat:true},\
#        consumable={\
#            consume_seconds:0,\
#            on_consume_effects:[{type:"apply_effects",effects:[\
#                {id:"instant_health",amplifier:0,duration:3}]}]},\
#            use_remainder={"id":"bowl",count:1},\
#        custom_data={"imperium_healing":1b}\
#    ] 10
loot give @s loot imperium:smokey/healing

#   Ability Cooldowns
scoreboard players operation @s im_abilityCdA = #Smokey im_abilityCdA
scoreboard players operation @s im_abilityCdB = #Smokey im_abilityCdB
scoreboard players operation @s im_abilityCdC = #Smokey im_abilityCdC

tag @s add im.kit_smokey