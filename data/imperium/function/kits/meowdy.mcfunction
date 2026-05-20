item replace entity @s armor.head with \
    netherite_helmet[\
        !max_damage,\
        attribute_modifiers=[\
            {type:"armor",amount:12,operation:"add_value",slot:"head",id:"head"},\
            {type:"movement_speed",amount:0.2,operation:"add_multiplied_base",slot:"head",id:"feet"}\
        ],\
        item_model="minecraft:leather_helmet",\
        dyed_color=16753920\
    ] 1
item replace entity @s armor.chest with \
    netherite_chestplate[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:chainmail_chestplate"\
    ] 1
item replace entity @s armor.legs with \
    netherite_leggings[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:chainmail_leggings"\
    ] 1
item replace entity @s armor.feet with \
    netherite_boots[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_boots",\
        dyed_color=4673362\
    ] 1
# colors: 16753920 helmet, 4673362 boots

item replace entity @s hotbar.0 with \
    netherite_sword[\
        !max_damage,\
        item_model="minecraft:iron_sword",\
        attribute_modifiers=[\
            {type:"attack_damage",amount:5,operation:"add_value",slot:"mainhand",id:"base_attack_damage"},\
            {type:"attack_speed",amount:-2.4,operation:"add_value",slot:"mainhand",id:"base_attack_speed"}\
        ]\
    ] 1

item replace entity @s weapon.offhand with \
    crossbow[\
        !max_damage,\
        enchantments={\
            "quick_charge":3,"multishot":1\
        }\
    ] 1

item replace entity @s hotbar.1 with \
    crossbow[\
        !max_damage,\
        enchantments={\
            "multishot":1\
        }\
    ] 1

item replace entity @s hotbar.8 with \
    arrow 4

#   Healing Item: Salmon
give @s cooked_salmon[\
    max_stack_size=1,\
    food={nutrition:0,saturation:0,can_always_eat:true},\
    consumable={\
        consume_seconds:0,\
        on_consume_effects:[{type:"apply_effects",effects:[\
            {id:"instant_health",amplifier:1,duration:1}]}]}] 16

scoreboard players set @s rArrow 4
scoreboard players set @s rMushSoup 1
