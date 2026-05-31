#   [Kit Name] - [Kit Description]

#   Armor
item replace entity @s armor.head with \
    netherite_helmet[\
        !max_damage,\
        enchantments={"protection":8},\
        attribute_modifiers=[\
            {type:"armor",amount:10,operation:"add_value",slot:"head",id:"head"},\
            {type:"armor_toughness",amount:8,operation:"add_value",slot:"head",id:"head_toughness"}],\
        item_model="minecraft:leather_helmet",\
        dyed_color=8073150,\
        item_name={color:"light_purple",italic:false,text:"[Kit] Helmet"}\
    ] 1
item replace entity @s armor.chest with \
    netherite_chestplate[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_chestplate",\
        dyed_color=8073150,\
        item_name={color:"light_purple",italic:false,text:"[Kit] Chestplate"}\
    ] 1
item replace entity @s armor.legs with \
    netherite_leggings[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_leggings",\
        dyed_color=8073150,\
        item_name={color:"light_purple",italic:false,text:"[Kit] Leggings"}\
    ] 1
item replace entity @s armor.feet with \
    netherite_boots[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_boots",\
        dyed_color=8073150,\
        item_name={color:"light_purple",italic:false,text:"[Kit] Boots"}\
    ] 1

#   [Weapon Name]: [damage]|[speed], [enchantments]
#   [Weapon description]
item replace entity @s hotbar.0 with \
    netherite_sword[\
        !max_damage,\
        item_model="minecraft:end_rod",\
        custom_name={color:"light_purple",italic:false,text:"[Weapon Name]"},\
        attribute_modifiers=[\
            {type:"attack_damage",amount:7,operation:"add_value",slot:"mainhand",id:"base_attack_damage"},\
            {type:"attack_speed",amount:-2.4,operation:"add_value",slot:"mainhand",id:"base_attack_speed"}\
        ]\
    ] 1

#   [Secondary Name]: [damage]|[speed]
#   [Secondary description]
item replace entity @s hotbar.1 with \
    end_rod[\
        custom_name={color:"light_purple",italic:false,text:"[Secondary Name]"},\
        attribute_modifiers=[\
            {type:"attack_damage",amount:5,operation:"add_value",slot:"mainhand",id:"base_attack_damage"},\
            {type:"attack_speed",amount:-2.0,operation:"add_value",slot:"mainhand",id:"base_attack_speed"}\
        ]\
    ] 1

#   [Offhand / Hotbar items]

#   Healing Item: Chorus Fruit
give @s \
    chorus_fruit[\
        max_stack_size=1,\
        food={nutrition:0,saturation:0,can_always_eat:true},\
        consumable={\
            consume_seconds:0,\
            on_consume_effects:[\
                {type:"apply_effects",effects:[\
                    {id:"instant_health",amplifier:1,duration:1}]},\
                {type:"teleport_randomly",diameter:16}]}\
    ] 16
