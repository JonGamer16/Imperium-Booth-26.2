execute \
    unless items entity @s weapon.mainhand \
        *[minecraft:damage_type="imperium:shield_pierce"] \
    run item modify entity @s weapon.mainhand \
        imperium:apply_shield_pierce