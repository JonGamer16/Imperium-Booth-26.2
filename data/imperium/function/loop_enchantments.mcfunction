# Livvy
    # Life Steal (Livvy): bank damage dealt with the enchanted Fang, convert to soup.
    #   im_lsDealt (custom:damage_dealt) is a running total in 1/10 HP; delta = this tick.
    #   im_lsFlag was set this tick by the lifesteal enchantment while the weapon is held.
    #   100 banked = 10 HP dealt -> one empty bowl becomes a Blood Bowl soup.
    execute as @a[tag=im.kit_livvy] run scoreboard players operation \
        @s im_lsDelta = @s im_lsDealt
    execute as @a[tag=im.kit_livvy] run scoreboard players operation \
        @s im_lsDelta -= @s im_lsPrev
    execute as @a[tag=im.kit_livvy,scores={im_lsFlag=1..}] run scoreboard players operation \
        @s im_lifesteal += @s im_lsDelta
    execute as @a[tag=im.kit_livvy] run scoreboard players operation \
        @s im_lsPrev = @s im_lsDealt
    execute as @a[tag=im.kit_livvy] if score @s im_lifesteal >= #lsThreshold im_lifesteal \
        run function imperium:enchantments/lifesteal_soup
    #   Reset flags for next tick (the enchantment re-sets them while the weapon stays held)
    scoreboard players set @a[tag=im.kit_livvy] im_lsFlag 0