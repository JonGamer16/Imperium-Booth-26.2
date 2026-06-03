#   Cyborg Mummy

#   [ARMOR]
item replace entity @s armor.head with \
    netherite_helmet[\
        !max_damage,\
        attribute_modifiers=[\
            {id:"armor",type:"armor",amount:2,operation:"add_value",slot:"head"}],\
        item_model="minecraft:golden_helmet"\
    ] 1
item replace entity @s armor.chest with \
    netherite_chestplate[\
        !max_damage,\
        attribute_modifiers=[\
            {id:"armor",type:"armor",amount:5,operation:"add_value",slot:"chest"}],\
        item_model="minecraft:golden_chestplate"\
    ] 1
item replace entity @s armor.legs with \
    netherite_leggings[\
        !max_damage,\
        attribute_modifiers=[\
            {id:"armor",type:"armor",amount:3,operation:"add_value",slot:"legs"}],\
        item_model="minecraft:golden_leggings"\
    ] 1
item replace entity @s armor.feet with \
    netherite_boots[\
        !max_damage,\
        attribute_modifiers=[\
            {id:"armor",type:"armor",amount:1,operation:"add_value",slot:"feet"}],\
        item_model="minecraft:golden_boots"\
    ] 1

# Helmet - item_model="minecraft:player_head" is redundant (explicit default); swap to "minecraft:netherite_helmet" to revert appearance
item replace entity @s weapon.offhand with \
    player_head[\
        max_damage=70,\
        profile="Mummy",\
        item_model="minecraft:player_head",\
        enchantments={"protection":3,"imperium:chinks_curse":1,"imperium:brittle_curse":1},\
        custom_data={"imperium_kit":1b}\
    ] 1
item replace entity @s hotbar.6 with \
    netherite_chestplate[\
        max_damage=80,\
        item_model="minecraft:netherite_chestplate",\
        enchantments={"protection":3,"imperium:chinks_curse":1,"imperium:brittle_curse":1},\
        trim={material:"quartz",pattern:"silence"},\
        custom_data={"imperium_kit":1b}\
    ] 1
item replace entity @s hotbar.7 with \
    netherite_leggings[\
        max_damage=90,\
        item_model="minecraft:netherite_leggings",\
        enchantments={"protection":3,"imperium:chinks_curse":1,"imperium:brittle_curse":1},\
        trim={material:"quartz",pattern:"rib"},\
        custom_data={"imperium_kit":1b}\
    ] 1
item replace entity @s hotbar.8 with \
    netherite_boots[\
        max_damage=100,\
        item_model="minecraft:netherite_boots",\
        enchantments={"protection":3,"imperium:chinks_curse":1,"imperium:brittle_curse":1},\
        trim={material:"quartz",pattern:"rib"},\
        custom_data={"imperium_kit":1b}\
    ] 1

# Weapons

#   [MELEE] Golden Axe
#       7 | 1
item replace entity @s hotbar.0 with \
    netherite_axe[\
        !max_damage,\
        item_model="minecraft:golden_axe",\
        custom_data={"imperium_kit":1b}\
    ] 1

#   [MELEE] Charged Sword
#       6 | 1.6, Sweeping Edge 3
item replace entity @s hotbar.1 with \
    netherite_sword[\
        max_damage=20,\
        item_model="minecraft:golden_sword",\
        enchantments={"sharpness":3,"sweeping_edge":3,"imperium:chinks_curse":1},\
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