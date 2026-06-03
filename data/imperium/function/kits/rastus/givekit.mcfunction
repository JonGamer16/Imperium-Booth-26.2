#   Rastus the Duelist

#   [ARMOR]
item replace entity @s armor.head with \
    netherite_helmet[\
        !max_damage,\
        attribute_modifiers=[\
            {id:"head",type:"armor",amount:14,operation:"add_value",slot:"head"}],\
        item_model="minecraft:leather_helmet",\
        dyed_color=3949738,\
        trim={material:"lapis",pattern:"dune"}] 1
item replace entity @s armor.chest with \
    netherite_chestplate[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:chainmail_chestplate",\
        trim={material:"lapis",pattern:"silence"}] 1
item replace entity @s armor.legs with \
    netherite_leggings[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:chainmail_leggings",\
        trim={material:"lapis",pattern:"sentry"}] 1
item replace entity @s armor.feet with \
    netherite_boots[\
        !max_damage,\
        !attribute_modifiers,\
        item_model="minecraft:leather_boots",\
        dyed_color=3949738,\
        trim={material:"iron",pattern:"raiser"}] 1

#   [MELEE] Light Rapier
#       2 | 7, +1.0 Knockback
item replace entity @s hotbar.0 with \
    netherite_sword[\
        !max_damage,\
        item_model="minecraft:iron_sword",\
        damage_type="imperium:light",\
        minimum_attack_charge=1.0,\
        attribute_modifiers=[\
            {id:"attack_damage",type:"attack_damage",amount:2,operation:"add_value",slot:"mainhand"},\
            {id:"attack_speed",type:"attack_speed",amount:3,operation:"add_value",slot:"mainhand"},\
            {id:"attack_knockback",type:"attack_knockback",amount:-1.0,operation:"add_value",slot:"mainhand"}],\
        custom_data={"imperium_kit":1b}] 1

#   [HEALING] Splash Healing 2 Potion
#       16 x 8 HP
give @s potion[\
    potion_contents={custom_effects:[\
        {id:"instant_health",amplifier:1,duration:1}]},\
    custom_data={"imperium_healing":1b}\
    ] 16

#   Ability Cooldowns
scoreboard players operation @s im_abilityCdA = #Rastus im_abilityCdA
scoreboard players operation @s im_abilityCdB = #Rastus im_abilityCdB
scoreboard players operation @s im_abilityCdC = #Rastus im_abilityCdC

tag @s add im.kit_rastus