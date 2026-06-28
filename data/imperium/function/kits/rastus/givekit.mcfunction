#   Rastus the Duelist

function imperium:util/clear_kit

#   [ARMOR]
item replace entity @s armor.head with \
    netherite_helmet[\
        attribute_modifiers=[\
            {type:"armor",amount:17,operation:"add_value",slot:"head",id:"head"},\
            {type:"armor_toughness",amount:4,operation:"add_value",slot:"head",id:"head"},\
            {type:"movement_speed",amount:0.2,operation:"add_multiplied_base",slot:"head",id:"head"},\
        ],\
        !max_damage,\
        item_model="minecraft:leather_helmet",\
        equippable={slot:head,asset_id:"minecraft:leather"},\
        dyed_color=3949738,\
        trim={material:"lapis",pattern:"dune"},\
        custom_name={text:"Dueling Helmet",color:blue,italic:false},\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.chest with \
    netherite_chestplate[\
        !attribute_modifiers,\
        !max_damage,\
        item_model="minecraft:chainmail_chestplate",\
        equippable={slot:chest,asset_id:"minecraft:chainmail"},\
        trim={material:"lapis",pattern:"raiser"},\
        custom_name={text:"Dueling Chestplate",color:blue,italic:false},\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.legs with \
    netherite_leggings[\
        !attribute_modifiers,\
        !max_damage,\
        item_model="minecraft:chainmail_leggings",\
        equippable={slot:legs,asset_id:"minecraft:chainmail"},\
        trim={material:"lapis",pattern:"sentry"},\
        custom_name={text:"Dueling Leggings",color:blue,italic:false},\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.feet with \
    netherite_boots[\
        !attribute_modifiers,\
        !max_damage,\
        item_model="minecraft:leather_boots",\
        equippable={slot:feet,asset_id:"minecraft:leather"},\
        dyed_color=3949738,\
        trim={material:"iron",pattern:"raiser"},\
        custom_name={text:"Dueling Boots",color:blue,italic:false},\
        custom_data={"imperium_kit":1b},\
    ] 1

#   [MELEE] Lightning Rapier
#       2 | 7, +1.0 Knockback
item replace entity @s hotbar.0 with \
    netherite_sword[\
        attribute_modifiers=[\
            {type:"attack_damage",amount:1.5,operation:"add_value",slot:"mainhand",id:"base_attack_damage"},\
            {type:"attack_speed",amount:4,operation:"add_value",slot:"mainhand",id:"base_attack_speed"},\
            {type:"attack_knockback",amount:-1.0,operation:"add_value",slot:"mainhand",id:"attack_knockback"}],\
        damage_type="imperium:light",\
        minimum_attack_charge=1.0,\
        piercing_weapon={"deals_knockback":true},\
        enchantments={"imperium:wip_focus_attack":1},\
        !max_damage,\
        item_model="minecraft:iron_sword",\
        custom_name={text:"Lightning Rapier",color:blue,italic:false},\
        custom_data={"imperium_kit":1b},\
    ] 1

#   [SLOT 1] Buckler
#item replace entity @s weapon.offhand with \
#    shield[\
#        !max_damage,\
#        custom_name={text:"Buckler Shield",color:blue,italic:false},\
#        custom_data={"imperium_kit":1b},\
#    ]
function imperium:kits/rastus/cd1_shield

#   [SLOT 2] [Empty]

#   [SLOT 3] [Empty]

#   [HEALING] Splash Healing 2 Potion
#       16 x 8 HP
#give @s \
#    potion[\
#        potion_contents={custom_effects:[\
#            {id:"instant_health",amplifier:1,duration:1}]},\
#        custom_data={"imperium_healing":1b}\
#    ] 16
loot give @s loot imperium:rastus/healing

#   Ability Cooldowns
scoreboard players operation @s im_abilityCdA = #Rastus im_abilityCdA
scoreboard players operation @s im_abilityCdB = #Rastus im_abilityCdB
scoreboard players operation @s im_abilityCdC = #Rastus im_abilityCdC

tag @s add im.kit_rastus