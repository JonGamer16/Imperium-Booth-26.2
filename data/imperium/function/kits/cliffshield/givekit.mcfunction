#   Shieldsman Kit - Balanced melee with shield and ranged option

#   [ARMOR]
item replace entity @s armor.head with \
    netherite_helmet[\
        !max_damage,\
        attribute_modifiers=[\
            {type:"armor",amount:15,operation:"add_value",slot:"head",id:"head"},\
            {type:"step_height",amount:0.5,operation:"add_value",slot:"head",id:"head"},\
        ],\
        item_model="minecraft:iron_helmet",\
        item_name={color:"white",italic:false,text:"Shieldsman Helmet"},\
        trim={material:"copper",pattern:"sentry"}\
    ] 1
item replace entity @s armor.chest with \
    netherite_chestplate[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:iron_chestplate",\
        custom_name={color:"white",italic:false,text:"Shieldsman Chestplate"},\
        trim={material:"copper",pattern:"coast"}\
    ] 1
item replace entity @s armor.legs with \
    netherite_leggings[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:chainmail_leggings",\
        custom_name={color:"white",italic:false,text:"Shieldsman Leggings"},\
        trim={material:"iron",pattern:"snout"}\
    ] 1
item replace entity @s armor.feet with \
    netherite_boots[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:iron_boots",\
        custom_name={color:"white",italic:false,text:"Shieldsman Boots"},\
        trim={material:"iron",pattern:"snout"}\
    ] 1

#   [MELEE] Silver Glaive
#       7 | 1.2, +0.3 Reach, -0.5 Knockback
item replace entity @s hotbar.1 with \
    netherite_sword[\
        !max_damage,\
        item_model="minecraft:iron_sword",\
        custom_name={color:"white",italic:false,text:"Silver Glaive"},\
        attribute_modifiers=[\
            {type:"attack_damage",amount:6,operation:"add_value",slot:"mainhand",id:"base_attack_damage"},\
            {type:"attack_speed",amount:-2.8,operation:"add_value",slot:"mainhand",id:"base_attack_speed"},\
            {type:"entity_interaction_range",amount:0.3,operation:"add_value",slot:"mainhand",id:"mainhand"},\
            {type:"attack_knockback",amount:-0.5,operation:"add_value",slot:"mainhand",id:"mainhand"},\
        ]\
    ] 1

#   [MELEE] Steel Broadsword
#       6|1.4, +0.1 KBR, Sweeping Edge 3
item replace entity @s hotbar.0 with \
    netherite_sword[\
        !max_damage,\
        item_model="minecraft:stone_sword",\
        enchantments={\
            "sweeping_edge":3\
        },\
        custom_name={\
            color:"white",\
            italic:false,\
            text:"Steel Broadsword"\
        },\
        attribute_modifiers=[\
            {type:"attack_damage",amount:5,operation:"add_value",slot:"mainhand",id:"base_attack_damage"},\
            {type:"attack_speed",amount:-2.6,operation:"add_value",slot:"mainhand",id:"base_attack_speed"},\
            {type:"knockback_resistance",amount:0.1,operation:"add_value",slot:"mainhand",id:"knockback_resistance"}\
        ]\
    ] 1

#   [TOOL] Light Crossbow: 2 Arrows
item replace entity @s hotbar.2 with \
    crossbow[\
        !max_damage,\
        custom_name={color:"white",italic:false,text:"Light Crossbow"},\
        enchantments={"minecraft:power":1}\
    ] 1

#   [SLOT 1] Shield
#       30hp, 0.35s delay, 60 deg angle
item replace entity @s weapon.offhand with \
    shield[\
        max_damage=30,\
        base_color="black",\
        banner_patterns=[\
            {pattern:"gradient",color:"white"},\
            {pattern:"gradient_up",color:"light_gray"},\
            {pattern:"straight_cross",color:"gray"},\
            {pattern:"border",color:"gray"},\
            {pattern:"rhombus",color:"gray"}\
        ],\
        blocks_attacks={\
            item_damage:{base:1,factor:1,threshold:8},\
            damage_reductions:[\
                {type:"generic",base:1,factor:1,horizontal_blocking_angle:60}\
            ],\
            block_delay_seconds:0.35\
        }\
    ] 1

#   [SLOT 2] Arrows
item replace entity @s hotbar.8 with \
    arrow 2

#   [SLOT 3] Rook Rush
item replace entity @s hotbar.3 with \
    potion[\
        potion_contents={\
            custom_effects:[\
                {id:"minecraft:speed",amplifier:4,duration:1s}\
            ]}\
    ] 1

#   [HEAL] Mushroom Stew
give @s mushroom_stew[\
    food={nutrition:0,saturation:0,can_always_eat:true},\
    consumable={\
        consume_seconds:0,\
        on_consume_effects:[{type:"apply_effects",effects:[\
            {id:"instant_health",amplifier:1,duration:1}]}]},\
        use_remainder={id:"bowl",count:1}] 16

scoreboard players set @s im_abilityCdA 300
scoreboard players set @s im_abilityCdB 300
scoreboard players set @s im_abilityCdC 300
