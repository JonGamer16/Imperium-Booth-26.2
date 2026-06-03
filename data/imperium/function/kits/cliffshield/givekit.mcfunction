#   Jeru Cliffshield

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
        trim={material:"copper",pattern:"sentry"},\
        custom_data={"imperium_kit":1b}\
    ] 1
item replace entity @s armor.chest with \
    netherite_chestplate[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:iron_chestplate",\
        custom_name={color:"white",italic:false,text:"Shieldsman Chestplate"},\
        trim={material:"copper",pattern:"coast"},\
        custom_data={"imperium_kit":1b}\
    ] 1
item replace entity @s armor.legs with \
    netherite_leggings[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:chainmail_leggings",\
        custom_name={color:"white",italic:false,text:"Shieldsman Leggings"},\
        trim={material:"iron",pattern:"snout"},\
        custom_data={"imperium_kit":1b}\
    ] 1
item replace entity @s armor.feet with \
    netherite_boots[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:iron_boots",\
        custom_name={color:"white",italic:false,text:"Shieldsman Boots"},\
        trim={material:"iron",pattern:"snout"},\
        custom_data={"imperium_kit":1b}\
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
        ],\
        custom_data={"imperium_kit":1b}\
    ] 1

#   [MELEE] Steel Broadsword
#       6 | 1.4, +0.1 KBR, Sweeping Edge 3
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
        ],\
        custom_data={"imperium_kit":1b}\
    ] 1

#   [TOOL] Light Crossbow
item replace entity @s hotbar.2 with \
    crossbow[\
        !max_damage,\
        custom_name={color:"white",italic:false,text:"Light Crossbow"},\
        enchantments={"minecraft:power":1},\
        custom_data={"imperium_kit":1b},\
    ] 1

#   [SLOT 1] Shield
#       30hp, 0.35s delay, 60 deg angle
function imperium:kits/cliffshield/cd1_shield

#   [SLOT 2] Arrows
#       2 count
function imperium:kits/cliffshield/cd2_arrows

#   [SLOT 3] Rook Rush
#       Speed 5 | 1s
function imperium:kits/cliffshield/cd3_potion


#   [HEAL] Mushroom Stew
loot give @s loot imperium:cliffshield/healing

scoreboard players operation @s im_abilityCdA = #Cliffshield im_abilityCdA
scoreboard players operation @s im_abilityCdB = #Cliffshield im_abilityCdB
scoreboard players operation @s im_abilityCdC = #Cliffshield im_abilityCdC

tag @s add im.kit_cliffshield