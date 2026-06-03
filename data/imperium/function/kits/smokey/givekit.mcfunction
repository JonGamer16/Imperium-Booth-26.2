#   Smokey Bat

#   [ARMOR]
item replace entity @s armor.head with \
    netherite_helmet[\
        !max_damage,\
        attribute_modifiers=[\
            {id:"armor",type:"armor",amount:14,operation:"add_value",slot:"head"}\
        ],\
        item_model="minecraft:leather_helmet",\
        dyed_color=8606770,\
        trim={material:"copper",pattern:"dune"}\
    ] 1
item replace entity @s armor.chest with \
    netherite_chestplate[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:chainmail_chestplate",\
        trim={material:"iron",pattern:"silence"}\
    ] 1
item replace entity @s armor.legs with \
    netherite_leggings[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_leggings",\
        dyed_color=14464401,\
        trim={material:"iron",pattern:"snout"}\
    ] 1
item replace entity @s armor.feet with \
    netherite_boots[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_boots",\
        dyed_color=14464401,\
        trim={material:"copper",pattern:"bolt"}\
    ] 1

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

#   [HEALING] Rabbit Stew
#       10 x 12 HP
give @s rabbit_stew\
    [\
        food={nutrition:0,saturation:0,can_always_eat:true},\
        consumable={\
            consume_seconds:0,\
            on_consume_effects:[{type:"apply_effects",effects:[\
                {id:"instant_health",amplifier:0,duration:3}]}]},\
            use_remainder={"id":"bowl",count:1},\
        custom_data={"imperium_healing":1b}\
    ] 10

#   Ability Cooldowns
scoreboard players operation @s im_abilityCdA = #Smokey im_abilityCdA
scoreboard players operation @s im_abilityCdB = #Smokey im_abilityCdB
scoreboard players operation @s im_abilityCdC = #Smokey im_abilityCdC

tag @s add im.kit_smokey