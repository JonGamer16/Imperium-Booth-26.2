#   Levent the Shulker Knight

#   [ARMOR]
item replace entity @s armor.head with \
    netherite_helmet[\
        !max_damage,\
        enchantments={"protection":8},\
        attribute_modifiers=[\
            {type:"armor",amount:10,operation:"add_value",slot:"head",id:"head"},\
            {type:"armor_toughness",amount:8,operation:"add_value",slot:"head",id:"head_toughness"}],\
        item_model="minecraft:leather_helmet",\
        dyed_color=8073150,\
        custom_name={color:"light_purple",italic:false,text:"Shulker Lid"},\
        trim={material:"amethyst",pattern:"spire"},\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.chest with \
    netherite_chestplate[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_chestplate",\
        dyed_color=8073150,\
        custom_name={color:"light_purple",italic:false,text:"Shulker Box"},\
        trim={material:"amethyst",pattern:"spire"},\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.legs with \
    netherite_leggings[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_leggings",\
        dyed_color=8073150,\
        custom_name={color:"light_purple",italic:false,text:"Shulker Pillar"},\
        trim={material:"amethyst",pattern:"spire"},\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.feet with \
    netherite_boots[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_boots",\
        dyed_color=8073150,\
        custom_name={color:"light_purple",italic:false,text:"Shulker Base"},\
        trim={material:"amethyst",pattern:"spire"},\
        custom_data={"imperium_kit":1b},\
    ] 1

#   [MELEE] End Rod
#       5 | 2
item replace entity @s hotbar.0 with \
    netherite_sword[\
        !max_damage,\
        item_model="minecraft:end_rod",\
        custom_name={color:"light_purple",italic:false,text:"End Rod"},\
        attribute_modifiers=[\
            {type:"attack_damage",amount:4,operation:"add_value",slot:"mainhand",id:"base_attack_damage"},\
            {type:"attack_speed",amount:-2,operation:"add_value",slot:"mainhand",id:"base_attack_speed"}\
        ],\
        custom_data={"imperium_kit":1b},\
    ] 1

#   [TOOL] Bow
item replace entity @s hotbar.1 with \
    bow[\
        !max_damage,\
        custom_name={color:"white",italic:false,text:"Aero Shot"},\
        custom_data={"imperium_kit":1b},\
    ] 1

#   [TOOL] Gravity Flower
item replace entity @s weapon.offhand with \
    chorus_flower[\
        max_damage=30,\
        custom_name={color:"white",italic:false,text:"Reversal Shield"},\
        attribute_modifiers=[\
            {type:"gravity",amount:-0.5,operation:"add_multiplied_base",slot:"hand",id:"hand"}\
        ],\
        custom_data={"imperium_kit":1b}\
    ] 1

#   [SLOT 1] Levitation Arrow
item replace entity @s hotbar.8 with \
    tipped_arrow[\
        potion_contents={custom_effects:[\
            {id:"levitation",amplifier:1,duration:50}]},\
        custom_data={"imperium_kit":1b}\
    ] 1

#   [SLOT 2] Shield
item replace entity @s weapon.offhand with \
    shield[\
        max_damage=30,\
        custom_name={color:"white",italic:false,text:"Reversal Shield"},\
        custom_data={"imperium_kit":1b}\
    ]

#   [SLOT 3] [Empty]

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
                {type:"teleport_randomly",diameter:16}]},\
        custom_data={imperium_healing:1b}\
    ] 16

#   Ability Cooldowns
scoreboard players operation @s im_abilityCdA = #Levent im_abilityCdA
scoreboard players operation @s im_abilityCdB = #Levent im_abilityCdB
scoreboard players operation @s im_abilityCdC = #Levent im_abilityCdC

tag @s add im.kit_levent