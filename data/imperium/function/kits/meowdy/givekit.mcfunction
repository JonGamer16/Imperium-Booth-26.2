#   Quin Meowdy

function imperium:util/clear_kit

#   [ARMOR]
item replace entity @s armor.head with \
    netherite_helmet[\
        !max_damage,\
        attribute_modifiers=[\
            {type:"armor",amount:16,operation:"add_value",slot:"head",id:"head"},\
            {type:"armor_toughness",amount:8,operation:"add_value",slot:"head",id:"head"},\
            {type:"movement_speed",amount:0.2,operation:"add_multiplied_base",slot:"head",id:"head"},\
            {type:"sneaking_speed",amount:1,operation:"add_value",slot:"head",id:"head"},\
            {type:"safe_fall_distance",amount:6,operation:"add_value",slot:head,id:"head"},\
            {type:"fall_damage_multiplier",amount:-0.5,operation:"add_value",slot:head,id:"head"},\
            {type:"attack_knockback",amount:1,operation:"add_value",slot:"head",id:"head"},\
            {type:"knockback_resistance",amount:0.44,operation:"add_value",slot:"head",id:"head"},\
        ],\
        item_model="minecraft:leather_helmet",\
        equippable={slot:head,asset_id:"minecraft:leather"},\
        custom_name={color:"gold",italic:false,text:"Meowdy's Cap"},\
        dyed_color=16753920,\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.chest with \
    netherite_chestplate[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:chainmail_chestplate",\
        equippable={slot:chest,asset_id:"minecraft:chainmail"},\
        custom_name={color:"gold",italic:false,text:"Meowdy's Chestplate"},\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.legs with \
    netherite_leggings[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_leggings",\
        equippable={slot:legs,asset_id:"minecraft:leather"},\
        dyed_color=16753920,\
        custom_name={color:"gold",italic:false,text:"Meowdy's Pants"},\
        custom_data={"imperium_kit":1b},\
    ] 1
item replace entity @s armor.feet with \
    netherite_boots[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_boots",\
        equippable={slot:feet,asset_id:"minecraft:leather"},\
        custom_name={color:"gold",italic:false,text:"Meowdy's Boots"},\
        dyed_color=14011067,\
        custom_data={"imperium_kit":1b},\
    ] 1
# colors: 16753920 helmet, 4673362 boots

#   [MELEE] Shortsword
#       6 | 2
item replace entity @s hotbar.0 with \
    netherite_sword[\
        attribute_modifiers=[\
            {type:"attack_damage",amount:5,operation:"add_value",slot:"mainhand",id:"base_attack_damage"},\
            {type:"attack_speed",amount:-2,operation:"add_value",slot:"mainhand",id:"base_attack_speed"}\
        ],\
        !max_damage,\
        item_model="minecraft:iron_sword",\
        custom_name={text:"Shortsword",color:gold,italic:false},\
        custom_data={"imperium_kit":1b}\
    ] 1

#   [TOOL] Quickdraw Crossbow
#       Quick Charge 3
item replace entity @s weapon.offhand with \
    crossbow[\
        enchantments={\
            "quick_charge":3\
        },\
        !max_damage,\
        custom_name={text:"Quickdraw",color:"gold",italic:false},\
        custom_data={"imperium_kit":1b}\
    ] 1

#   [MELEE] Cat Claw
#       4 | 10, -0.5 Knockback
item replace entity @s hotbar.1 with \
    netherite_sword[\
        item_model="minecraft:ghast_tear",\
        attribute_modifiers=[\
            {type:"attack_damage",amount:3,operation:"add_value",slot:"mainhand",id:"base_attack_damage"},\
            {type:"attack_speed",amount:6,operation:"add_value",slot:"mainhand",id:"base_attack_speed"},\
            {type:"attack_knockback",amount:-0.5,operation:"add_value",slot:"mainhand",id:"mainhand"}\
        ],\
        !max_damage,\
        custom_name={text:"Cat Claw",color:gold,italic:false},\
        custom_data={"imperium_kit":1b}\
    ] 1

#   [TOOL] Birdshot Crossbow
#       Multishot
item replace entity @s hotbar.2 with \
    crossbow[\
        !max_damage,\
        enchantments={\
            "multishot":1\
        },\
        custom_name={text:"Birdshot",color:gold,italic:false},\
        custom_data={"imperium_kit":1b}\
    ] 1

#   [SLOT 1] Leap Feather
#item replace entity @s weapon.offhand with \
#    feather[\
#        enchantments={"imperium:leap":2},\
#        custom_data={"imperium_kit":1b},\
#    ] 1
function imperium:kits/meowdy/cd1_feather

#   [SLOT 2] Arrows (multi-charge, count-based)
#       Give the full stack now, then tie max charges to the actual count given so the
#       loot table stays the single source of truth. cd2_arrows refills one at a time.
loot give @s loot imperium:meowdy/arrows
execute store result score @s im_cdMaxB run clear @s arrow[custom_data~{imperium_kit:1b}] 0
# Seed the charge count to the full stack so the slot starts frozen (full). After this it's kept
# in sync purely by events: imperium:internal/arrow_recount on each shot, and cd2_arrows on refill.
scoreboard players operation @s im_cdUsesB = @s im_cdMaxB

#   [SLOT 3] [Empty]

#   [HEALING] Salmon
#       16x 8hp
#give @s cooked_salmon[\
#    max_stack_size=1,\
#    food={nutrition:0,saturation:0,can_always_eat:true},\
#    consumable={\
#        consume_seconds:0,\
#        on_consume_effects:[{type:"apply_effects",effects:[\
#            {id:"instant_health",amplifier:1,duration:1}]}]},\
#    custom_data={"imperium_healing":1b}] 16
loot give @s loot imperium:meowdy/healing

#   Ability Cooldowns
scoreboard players operation @s im_abilityCdA = #Meowdy im_abilityCdA
scoreboard players operation @s im_abilityCdB = #Meowdy im_abilityCdB
scoreboard players operation @s im_abilityCdC = #Meowdy im_abilityCdC

tag @s add im.kit_meowdy