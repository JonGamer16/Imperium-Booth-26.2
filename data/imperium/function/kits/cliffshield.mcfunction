#   Shieldsman Kit - Balanced melee with shield and ranged option

#   Armor
item replace entity @s armor.head with \
    netherite_helmet[\
        !max_damage,\
        attribute_modifiers=[\
            {type:"armor",amount:15,operation:"add_value",slot:"head",id:"head"}],\
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

#   Steel Broadsword 6|1.4, +0.1 KBR, Sweeping Edge 3
#   Slower but sturdy main with multitarget potential
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
            
#   Shield: 15hp
item replace entity @s weapon.offhand with \
    shield[\
        damage=321,\
        base_color="black",\
        banner_patterns=[\
            {pattern:"gradient",color:"white"},\
            {pattern:"gradient_up",color:"light_gray"},\
            {pattern:"straight_cross",color:"gray"},\
            {pattern:"border",color:"gray"},\
            {pattern:"rhombus",color:"gray"}\
        ],\
        attribute_modifiers=[\
            {type:"attack_speed",amount:-0.2,operation:"add_value",slot:"offhand",id:"attack_speed"}\
        ],\
        blocks_attacks={\
            item_damage:{base:1,factor:1,threshold:8},\
            damage_reductions:[\
                {type:"generic",base:1,factor:1,horizontal_blocking_angle:90}\
            ]\
        }\
    ] 1
    #{type:"arrow",base:0.5,factor:0.5},\
                #{type:"potion_harm",base:1,factor:1}\

#   Silver Dagger: 5|2, Smite 2
#   Anti-strafe option
item replace entity @s hotbar.1 with \
    netherite_sword[\
        !max_damage,\
        item_model="minecraft:iron_sword",\
        enchantments={"smite":2},\
        custom_name={color:"white",italic:false,text:"Silver Dagger"},\
        attribute_modifiers=[\
            {type:"attack_damage",amount:4,operation:"add_value",slot:"mainhand",id:"base_attack_damage"},\
            {type:"attack_speed",amount:-2,operation:"add_value",slot:"mainhand",id:"base_attack_speed"}\
        ]\
    ] 1

#   Light Crossbow: 2 Arrows
item replace entity @s hotbar.2 with \
    crossbow[\
        !max_damage,\
        custom_name={color:"white",italic:false,text:"Light Crossbow"},\
    ] 1

item replace entity @s hotbar.8 with \
    arrow 2

#   Healing Item: Mushroom Stew
give @s mushroom_stew[\
    food={nutrition:0,saturation:0,can_always_eat:true},\
    consumable={\
        consume_seconds:0,\
        on_consume_effects:[{type:"apply_effects",effects:[\
            {id:"instant_health",amplifier:1,duration:1}]}]},\
        use_remainder={id:"bowl",count:1}] 16

scoreboard players set @s rShield 1
scoreboard players set @s rArrow 2
scoreboard players set @s rMushSoup 1

# Optimize:
# - Replace @e[type=#imperium:human,scores={givekit=11}] with @s b/c givekit.mcfunction does the target selection
# - Need a system to copy/paste a good chunk of a kits code, a baseline would help, then Ill
#     also need to add code to it for things that could be found in most kits