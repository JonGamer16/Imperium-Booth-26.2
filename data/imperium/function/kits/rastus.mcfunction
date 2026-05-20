# Armor
item replace entity @s armor.head with \
    netherite_helmet[\
        !max_damage,\
        attribute_modifiers=[\
            {id:"head",type:"armor",amount:2,operation:"add_value",slot:"head"}],\
        item_model="minecraft:leather_helmet",\
        dyed_color=3949738] 1
item replace entity @s armor.chest with \
    netherite_chestplate[\
        !max_damage,\
        attribute_modifiers=[\
            {id:"chest",type:"armor",amount:5,operation:"add_value",slot:"chest"}],\
        item_model="minecraft:chainmail_chestplate"] 1
item replace entity @s armor.legs with \
    netherite_leggings[\
        !max_damage,\
        attribute_modifiers=[\
            {id:"legs",type:"armor",amount:5,operation:"add_value",slot:"legs"}],\
        item_model="minecraft:chainmail_leggings"] 1
item replace entity @s armor.feet with \
    netherite_boots[\
        !max_damage,\
        attribute_modifiers=[\
            {id:"feet",type:"armor",amount:2,operation:"add_value",slot:"feet"}],\
        item_model="minecraft:leather_boots",\
        dyed_color=3949738] 1

# Weapon
item replace entity @s hotbar.0 with \
    netherite_sword[\
        !max_damage,\
        item_model="minecraft:iron_sword",\
        damage_type="imperium:light",\
        minimum_attack_charge=1.0,\
        attribute_modifiers=[\
            {id:"attack_damage",type:"attack_damage",amount:2,operation:"add_value",slot:"mainhand"},\
            {id:"attack_speed",type:"attack_speed",amount:2.7,operation:"add_value",slot:"mainhand"},\
            {id:"attack_knockback",type:"attack_knockback",amount:-1.0,operation:"add_value",slot:"mainhand"}]] 1

#   Healing Item: Instant Health II Potion
give @s potion[\
    potion_contents={custom_effects:[\
        {id:"instant_health",amplifier:1,duration:1}]}] 16

scoreboard players set @s rHeal2Pot 1
