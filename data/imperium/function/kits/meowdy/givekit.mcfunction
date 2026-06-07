#   Quin Meowdy

#   [ARMOR]
item replace entity @s armor.head with \
    netherite_helmet[\
        !max_damage,\
        attribute_modifiers=[\
            {type:"armor",amount:12,operation:"add_value",slot:"head",id:"head"},\
            {type:"movement_speed",amount:0.2,operation:"add_multiplied_base",slot:"head",id:"feet"}\
        ],\
        item_model="minecraft:leather_helmet",\
        custom_name={color:"gold",italic:false,text:"Meowdy's Cap"},\
        dyed_color=16753920,\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.chest with \
    netherite_chestplate[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:chainmail_chestplate",\
        custom_name={color:"gold",italic:false,text:"Meowdy's Chestplate"},\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.legs with \
    netherite_leggings[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:chainmail_leggings",\
        custom_name={color:"gold",italic:false,text:"Meowdy's Leggings"},\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.feet with \
    netherite_boots[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_boots",\
        custom_name={color:"gold",italic:false,text:"Meowdy's Boots"},\
        dyed_color=4673362,\
        custom_data={"imperium_kit":1b},\
    ] 1
# colors: 16753920 helmet, 4673362 boots

#   [MELEE]
item replace entity @s hotbar.0 with \
    netherite_sword[\
        !max_damage,\
        item_model="minecraft:iron_sword",\
        attribute_modifiers=[\
            {type:"attack_damage",amount:5,operation:"add_value",slot:"mainhand",id:"base_attack_damage"},\
            {type:"attack_speed",amount:-2.4,operation:"add_value",slot:"mainhand",id:"base_attack_speed"}\
        ],\
        custom_data={"imperium_kit":1b}\
    ] 1

item replace entity @s weapon.offhand with \
    crossbow[\
        !max_damage,\
        enchantments={\
            "quick_charge":3\
        },\
        custom_data={"imperium_kit":1b}\
    ] 1

item replace entity @s hotbar.1 with \
    netherite_sword[\
        !max_damage,\
        item_model="minecraft:ghast_tear",\
        attribute_modifiers=[\
            {type:"attack_damage",amount:3,operation:"add_value",slot:"mainhand",id:"base_attack_damage"},\
            {type:"attack_speed",amount:6,operation:"add_value",slot:"mainhand",id:"base_attack_speed"},\
            {type:"attack_knockback",amount:-1,operation:"add_value",slot:"mainhand",id:"mainhand"}\
        ],\
        custom_data={"imperium_kit":1b}\
    ] 1

item replace entity @s hotbar.2 with \
    crossbow[\
        !max_damage,\
        enchantments={\
            "multishot":1\
        },\
        custom_data={"imperium_kit":1b}\
    ] 1

item replace entity @s hotbar.8 with \
    arrow[custom_data={"imperium_kit":1b}] 4

#   Healing Item: Salmon
give @s cooked_salmon[\
    max_stack_size=1,\
    food={nutrition:0,saturation:0,can_always_eat:true},\
    consumable={\
        consume_seconds:0,\
        on_consume_effects:[{type:"apply_effects",effects:[\
            {id:"instant_health",amplifier:1,duration:1}]}]},\
    custom_data={"imperium_healing":1b}] 16

#   Ability Cooldowns
scoreboard players operation @s im_abilityCdA = #Meowdy im_abilityCdA
scoreboard players operation @s im_abilityCdB = #Meowdy im_abilityCdB
scoreboard players operation @s im_abilityCdC = #Meowdy im_abilityCdC

tag @s add im.kit_meowdy