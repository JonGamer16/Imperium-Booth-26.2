#   Cyborg Mummy

#   [ARMOR]
# Helmet - item_model="minecraft:player_head" is redundant (explicit default); swap to "minecraft:netherite_helmet" to revert appearance
item replace entity @s armor.head with \
    player_head[\
        attribute_modifiers=[{type:"armor",amount:17,operation:"add_value",slot:head,id:"head"}],\
        enchantments={"protection":8},\
        !max_damage,\
        profile="Mummy",\
        item_model="minecraft:player_head",\
        custom_name={text:"Mummy Head"},\
        custom_data={"imperium_kit":1b}\
    ] 1
item replace entity @s armor.chest with \
    netherite_chestplate[\
        !max_damage,\
        item_model="minecraft:netherite_chestplate",\
        trim={material:"quartz",pattern:"silence"},\
        custom_name={text:"Mummy Chestplate"},\
        custom_data={"imperium_kit":1b}\
    ] 1
item replace entity @s armor.legs with \
    netherite_leggings[\
        !max_damage,\
        item_model="minecraft:netherite_leggings",\
        trim={material:"quartz",pattern:"rib"},\
        custom_name={text:"Mummy Leggings"},\
        custom_data={"imperium_kit":1b}\
    ] 1
item replace entity @s armor.feet with \
    netherite_boots[\
        !max_damage,\
        item_model="minecraft:netherite_boots",\
        trim={material:"quartz",pattern:"rib"},\
        custom_name={text:"Mummy Boots"},\
        custom_data={"imperium_kit":1b}\
    ] 1

# Weapons

#   [MELEE] Netherite Claymore
#       7 | 1.2
item replace entity @s hotbar.0 with \
    netherite_axe[\
        !max_damage,\
        item_model="minecraft:netherite_sword",\
        attribute_modifiers=[\
            {type:"attack_damage",amount:6,operation:add_value,slot:mainhand,id:"base_attack_damage"},\
            {type:"attack_speed",amount:-2.8,operation:add_value,slot:mainhand,id:"base_attack_speed"}\
        ],\
        custom_data={"imperium_kit":1b}\
    ] 1

#   [HEALING] Energy Crystal
#       10 x 8 HP, Regeneration 5|2s, 
give @s end_crystal[\
        !can_place_on,\
        custom_name="Energy Crystal",\
        max_stack_size=1,\
        food={nutrition:0,saturation:0,can_always_eat:true},\
        consumable={\
            consume_seconds:0,\
            on_consume_effects:[{type:"apply_effects",effects:[\
                {id:"instant_health",amplifier:1,duration:1s},\
                {id:"regeneration",amplifier:4,duration:2s}]}]},\
            use_remainder={"id":"bowl",count:1},\
        custom_data={"imperium_healing":1b}\
    ] 10

#   Ability Cooldowns
scoreboard players operation @s im_abilityCdA = #Mummy im_abilityCdA
scoreboard players operation @s im_abilityCdB = #Mummy im_abilityCdB
scoreboard players operation @s im_abilityCdC = #Mummy im_abilityCdC

tag @s add im.kit_mummy