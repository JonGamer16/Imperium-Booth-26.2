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
        custom_name={italic:false,text:"[Helmet Name]"}\
    ] 1
item replace entity @s armor.chest with \
    netherite_chestplate[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_chestplate",\
        dyed_color=4194304,\
        trim={material:"redstone",pattern:"silence"},\
        custom_name={italic:false,text:"[Chestplate Name]"}\
    ] 1
item replace entity @s armor.legs with \
    netherite_leggings[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_leggings",\
        dyed_color=4194304,\
        trim={material:"redstone",pattern:"silence"},\
        custom_name={italic:false,text:"[Leggings Name]"}\
    ] 1
item replace entity @s armor.feet with \
    netherite_boots[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_boots",\
        dyed_color=4194304,\
        trim={material:"redstone",pattern:"silence"},\
        custom_name={italic:false,text:"[Boots Name]"}\
    ] 1

item replace entity @s hotbar.0 with \
    netherite_sword[\
        !max_damage,\
        item_model="minecraft:iron_sword",\
        attribute_modifiers=[\
            {type:"attack_damage",amount:5,operation:"add_value",slot:"mainhand",id:"base_attack_damage"},\
            {type:"attack_speed",amount:-2.4,operation:"add_value",slot:"mainhand",id:"base_attack_speed"}\
        ],\
        custom_name={italic:false,text:"[Sword Name]"}\
    ] 1

#   Healing Item: Beetroot Soup
give @s beetroot_soup[\
    food={nutrition:0,saturation:0,can_always_eat:true},\
    consumable={\
        consume_seconds:0,\
        on_consume_effects:[{type:"apply_effects",effects:[\
            {id:"instant_health",amplifier:0,duration:1}]}]},\
        use_remainder={"id":"bowl",count:1}] 32

scoreboard players set @s rBeetSoup 1
