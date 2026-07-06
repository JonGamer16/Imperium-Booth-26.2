# 1. Stop if the mainhand item does NOT have the "imperium:temper" enchantment
# Uses direct NBT checking on the player's SelectedItem (mainhand)
execute \
    unless data entity @s SelectedItem.components."minecraft:enchantments"."imperium:temper" \
    run return 0

# 2. Establish spatial context and summon the temporary chest minecart
execute \
    at @s \
    run summon chest_minecart ~ ~ ~ \
        {Tags:["im_temp_cart"]}

# 3. Copy item to the minecart's first slot (container.0)
execute \
    at @s \
    run item replace \
        entity @e[type=chest_minecart,tag=im_temp_cart,sort=nearest,distance=..2,limit=1] container.0 \
        from entity @s weapon.mainhand

# 4. Handle Attribute Modifiers based on existing NBT state in the minecart

    # If the component EXISTS: Remove the old temper modifier using the exact namespace
    execute \
        at @s \
        if data \
            entity @e[type=chest_minecart,tag=im_temp_cart,sort=nearest,distance=..2,limit=1] \
            Items[{Slot:0b}].components."minecraft:attribute_modifiers" \
        run data remove \
            entity @e[type=chest_minecart,tag=im_temp_cart,sort=nearest,distance=..2,limit=1] \
            Items[{Slot:0b}].components."minecraft:attribute_modifiers"[{id:"imperium:temper"}]

    # Append the new modifier directly to the component array
    $execute \
        at @s \
        if data \
            entity @e[type=chest_minecart,tag=im_temp_cart,sort=nearest,distance=..2,limit=1] \
            Items[{Slot:0b}].components."minecraft:attribute_modifiers" \
        run data modify \
            entity @e[type=chest_minecart,tag=im_temp_cart,sort=nearest,distance=..2,limit=1] \
            Items[{Slot:0b}].components."minecraft:attribute_modifiers" \
        append value {type:"minecraft:attack_damage", id:"imperium:temper", amount:0.$(whole)$(decimal)d, operation:"add_multiplied_base", slot:"mainhand"}

    # If the component DOES NOT EXIST: Create it from scratch as an array
    $execute \
        at @s \
        unless data \
            entity @e[type=chest_minecart,tag=im_temp_cart,sort=nearest,distance=..2,limit=1] \
            Items[{Slot:0b}].components."minecraft:attribute_modifiers" \
        run data modify \
            entity @e[type=chest_minecart,tag=im_temp_cart,sort=nearest,distance=..2,limit=1] \
            Items[{Slot:0b}].components."minecraft:attribute_modifiers" \
        set value [{type:"minecraft:attack_damage", id:"imperium:temper", amount:0.$(whole)$(decimal)d, operation:"add_multiplied_base", slot:"mainhand"}]

# 5. Return item to player's mainhand
execute \
    at @s \
    run item replace \
        entity @s weapon.mainhand \
        from entity @e[type=chest_minecart,tag=im_temp_cart,sort=nearest,distance=..2,limit=1] container.0

# 5.5 Clear the minecart inventory to prevent drops
execute \
    at @s \
    run item replace \
    entity @e[type=chest_minecart,tag=im_temp_cart,sort=nearest,distance=..2,limit=1] container.0 \
    with air

# 6. Kill the chest cart
execute \
    at @s \
    run kill @e[type=chest_minecart,tag=im_temp_cart,sort=nearest,distance=..2,limit=1]