#   Levent the Shulker Knight

function imperium:util/clear_kit

#   [ARMOR]
item replace entity @s armor.head with \
    netherite_helmet[\
        !max_damage,\
        enchantments={"protection":12,"imperium:wip_high_jump":1},\
        attribute_modifiers=[\
            {type:"armor",amount:8,operation:"add_value",slot:"head",id:"head"},\
            {type:"armor_toughness",amount:8,operation:"add_value",slot:"head",id:"head"},\
            {type:"air_drag_modifier",amount:-0.2,operation:"add_multiplied_base",slot:"head",id:"head"},\
            {type:"safe_fall_distance",amount:2,operation:"add_multiplied_base",slot:"head",id:"head"},\
            {type:"fall_damage_multiplier",amount:-0.5,operation:"add_multiplied_base",slot:"head",id:"head"},\
        ],\
        item_model="minecraft:leather_helmet",\
        equippable={slot:head,asset_id:"minecraft:leather"},\
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
        equippable={slot:chest,asset_id:"minecraft:leather"},\
        dyed_color=8073150,\
        custom_name={color:"light_purple",italic:false,text:"Shulker Core"},\
        trim={material:"gold",pattern:"eye"},\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.legs with \
    netherite_leggings[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_leggings",\
        equippable={slot:legs,asset_id:"minecraft:leather"},\
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
        equippable={slot:feet,asset_id:"minecraft:leather"},\
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
        item_model="minecraft:breeze_rod",\
        custom_name={color:"light_purple",italic:false,text:"Light Rod"},\
        attribute_modifiers=[\
            {type:"attack_damage",amount:4,operation:"add_value",slot:"mainhand",id:"base_attack_damage"},\
            {type:"attack_speed",amount:-2,operation:"add_value",slot:"mainhand",id:"base_attack_speed"}\
        ],\
        piercing_weapon={deals_knockback:true},\
        minimum_attack_charge=0,\
        enchantments={"imperium:wip_charge_attack":1},\
        custom_data={"imperium_kit":1b},\
    ] 1

#   [TOOL] Bow
item replace entity @s hotbar.1 with \
    bow[\
        !max_damage,\
        enchantments={"imperium:wip_straight_flight":1},\
        custom_name={color:"white",italic:false,text:"Aero Shot"},\
        custom_data={"imperium_kit":1b},\
    ] 1

#   [TOOL] Gravity Flower
item replace entity @s hotbar.2 with \
    chorus_flower[\
        custom_name={color:"white",italic:false,text:"Gravity Flower"},\
        attribute_modifiers=[\
            {type:"gravity",amount:-0.75,operation:"add_multiplied_base",slot:"hand",id:"hand"}\
        ],\
        custom_data={"imperium_kit":1b}\
    ] 1

#   [SLOT 1] Levitation Arrow
#item replace entity @s hotbar.8 with \
#    tipped_arrow[\
#        potion_contents={custom_effects:[\
#            {id:"levitation",amplifier:1,duration:50}]},\
#        custom_data={"imperium_kit":1b}\
#    ] 1
function imperium:kits/levent/cd1_arrows

#   [SLOT 2] Shield
#item replace entity @s weapon.offhand with \
#    shield[\
#        max_damage=30,\
#        custom_name={color:"white",italic:false,text:"Reversal Shield"},\
#        custom_data={"imperium_kit":1b}\
#    ]
function imperium:kits/levent/cd2_shield

#   [SLOT 3] [Empty]

#   [HEALING] Chorus Fruit
#       16x 8hp, 16 block random teleport
#give @s \
#    chorus_fruit[\
#        max_stack_size=1,\
#        food={nutrition:0,saturation:0,can_always_eat:true},\
#        consumable={\
#            consume_seconds:0,\
#            on_consume_effects:[\
#                {type:"apply_effects",effects:[\
#                    {id:"instant_health",amplifier:1,duration:1}]},\
#                {type:"teleport_randomly",diameter:16}]},\
#        custom_data={imperium_healing:1b}\
#    ] 16
loot give @s loot imperium:levent/healing

#   Ability Cooldowns
scoreboard players operation @s im_abilityCdA = #Levent im_abilityCdA
scoreboard players operation @s im_abilityCdB = #Levent im_abilityCdB
scoreboard players operation @s im_abilityCdC = #Levent im_abilityCdC

tag @s add im.kit_levent