#   Warforged Mummy

function imperium:util/clear_kit

#   [ARMOR]
#   Helmet - item_model="minecraft:player_head" is redundant (explicit default); swap to "minecraft:netherite_helmet" to revert appearance
execute unless items entity @s armor.head * run \
    item replace entity @s armor.head with \
        player_head[\
            attribute_modifiers=[\
                {type:"armor",amount:15,operation:"add_value",slot:head,id:"head"},\
                {type:"armor_toughness",amount:8,operation:"add_value",slot:head,id:"head"},\
                {type:"attack_knockback",amount:1,operation:"add_value",slot:"head",id:"head"},\
                {type:"knockback_resistance",amount:0.44,operation:"add_value",slot:"head",id:"head"},\
            ],\
            enchantments={"imperium:barrier":1,"protection":8},\
            !max_damage,\
            profile="Mummy",\
            item_model="minecraft:player_head",\
            custom_name={text:"Mummy Head",color:blue,italic:false},\
            custom_data={"imperium_kit":1b}\
        ] 1
execute unless items entity @s armor.chest * run \
    item replace entity @s armor.chest with \
        netherite_chestplate[\
            !attribute_modifiers,\
            !max_damage,\
            item_model="minecraft:netherite_chestplate",\
            equippable={slot:chest,asset_id:"minecraft:netherite"},\
            trim={material:"quartz",pattern:"silence"},\
            custom_name={text:"Mummy Chestplate",color:blue,italic:false},\
            custom_data={"imperium_kit":1b}\
        ] 1
execute unless items entity @s armor.legs * run \
    item replace entity @s armor.legs with \
        netherite_leggings[\
            !attribute_modifiers,\
            !max_damage,\
            item_model="minecraft:netherite_leggings",\
            equippable={slot:legs,asset_id:"minecraft:netherite"},\
            trim={material:"quartz",pattern:"rib"},\
            custom_name={text:"Mummy Leggings",color:blue,italic:false},\
            custom_data={"imperium_kit":1b}\
        ] 1
execute unless items entity @s armor.feet * run \
    item replace entity @s armor.feet with \
        netherite_boots[\
            !attribute_modifiers,\
            !max_damage,\
            item_model="minecraft:netherite_boots",\
            equippable={slot:feet,asset_id:"minecraft:netherite"},\
            trim={material:"quartz",pattern:"rib"},\
            custom_name={text:"Mummy Boots",color:blue,italic:false},\
            custom_data={"imperium_kit":1b}\
        ] 1

#   [MELEE] Dark Claymore
#       7 | 1.2
execute unless items entity @s hotbar.0 * run \
    item replace entity @s hotbar.0 with \
        mace[\
            attribute_modifiers=[\
                {type:"attack_damage",amount:6,operation:add_value,slot:mainhand,id:"base_attack_damage"},\
                {type:"attack_speed",amount:-2.8,operation:add_value,slot:mainhand,id:"base_attack_speed"}\
            ],\
            enchantments={"imperium:golem_throw":1,"imperium:mace_smash":1},\
            !max_damage,\
            item_model="minecraft:netherite_sword",\
            custom_name={text:"Dark Claymore",color:dark_gray,italic:false},\
            custom_data={"imperium_kit":1b},\
        ] 1

#   [SLOT 1] Grappling Hook
function imperium:kits/mummy/cd1_rod

#   [SLOT 2] [Empty]

#   [SLOT 3] [Empty]

#   [HEALING] Energy Crystal
#       10 x 8 HP, Regeneration 5|2s,
loot give @s loot imperium:mummy/healing

#   Ability Cooldowns
scoreboard players operation @s im_abilityCdA = #Mummy im_abilityCdA
scoreboard players operation @s im_abilityCdB = #Mummy im_abilityCdB
scoreboard players operation @s im_abilityCdC = #Mummy im_abilityCdC

#   Energy meter (see kits/mummy/energy_*) — start full, capped at #MummyEnergyMax.
scoreboard players operation @s im_energy = #MummyEnergyStart im.param

tag @s add im.kit_mummy
