#   Livvy the Vampire Spider

#   [ARMOR]
item replace entity @s armor.head with \
    netherite_helmet[\
        !max_damage,\
        attribute_modifiers=[\
            {id:"armor",type:"armor",amount:12,operation:"add_value",slot:"head"},\
            {id:"sneaking_speed",type:"sneaking_speed",amount:1,operation:"add_value"},\
            {id:"movement_speed",type:"movement_speed",amount:0.2,operation:"add_multiplied_base"}\
        ],\
        item_model="minecraft:leather_helmet",\
        dyed_color=4194304,\
        trim={material:"redstone",pattern:"silence"},\
        custom_name={color:"red",italic:false,text:"Vampire Hood"},\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.chest with \
    netherite_chestplate[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_chestplate",\
        dyed_color=4194304,\
        trim={material:"redstone",pattern:"silence"},\
        custom_name={color:"red",italic:false,text:"Vampire Chestplate"},\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.legs with \
    netherite_leggings[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_leggings",\
        dyed_color=4194304,\
        trim={material:"redstone",pattern:"silence"},\
        custom_name={color:"red",italic:false,text:"Vampire Leggings"},\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.feet with \
    netherite_boots[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_boots",\
        dyed_color=4194304,\
        trim={material:"redstone",pattern:"silence"},\
        custom_name={color:"red",italic:false,text:"Vampire Boots"},\
        custom_data={"imperium_kit":1b},\
    ] 1

#   [MELEE] Fang
#       6 | 2, Crits, Lifesteal
item replace entity @s hotbar.0 with \
    netherite_sword[\
        !max_damage,\
        item_model="minecraft:ghast_tear",\
        attribute_modifiers=[\
            {type:"attack_damage",amount:5,operation:"add_value",slot:"mainhand",id:"base_attack_damage"},\
            {type:"attack_speed",amount:-2.4,operation:"add_value",slot:"mainhand",id:"base_attack_speed"}\
        ],\
        enchantments={"imperium:crits":3,"imperium:lifesteal":5},\
        custom_name={italic:false,text:"Lifesteal Fang"},\
        custom_data={"imperium_kit":1b}\
    ] 1

#   [SLOT 1] Leap Feather
item replace entity @s weapon.offhand with \
    feather[\
        enchantments={"imperium:wip_leap":2},\
        custom_data={"imperium_kit":1b},\
    ] 1

#   [SLOT 2] Throwable Web
item replace entity @s hotbar.1 with \
    cobweb[\
        max_stack_size=1,\
        consumable={consume_seconds:0.05,sound:"entity.spider.ambient"},\
        custom_data={"imperium_kit":1b},\
    ] 1

#   [SLOT 3] Acid Potion
item replace entity @s hotbar.2 with \
    splash_potion[\
        potion_contents={custom_effects:[\
            {id:"poison",amplifier:2,duration:40}]},\
        custom_data={"imperium_kit":1b},\
    ] 1

#   [HEALING] Beetroot Soup
#       20 x 8 HP
give @s beetroot_soup\
    [\
        food={nutrition:0,saturation:0,can_always_eat:true},\
        consumable={\
            consume_seconds:0,\
            on_consume_effects:[{type:"apply_effects",effects:[\
                {id:"instant_health",amplifier:0,duration:1}]}]},\
            use_remainder={"id":"bowl",count:1},\
        custom_data={"imperium_healing":1b}\
    ] 20

#   Ability Cooldowns
scoreboard players operation @s im_abilityCdA = #Livvy im_abilityCdA
scoreboard players operation @s im_abilityCdB = #Livvy im_abilityCdB
scoreboard players operation @s im_abilityCdC = #Livvy im_abilityCdC

tag @s add im.kit_livvy