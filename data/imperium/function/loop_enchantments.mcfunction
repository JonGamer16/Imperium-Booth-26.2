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

# ===== NON-KIT ENCHANTMENTS =====

# Brittle Score Control: Reset net damage if Brittle armor is not equipped
    # If brittle.mcfunction didn't run this tick (flag stayed 0), armor is off, so zero the accumulated damage
    # execute \
    #     as @a \
    #     unless score @s im_brittleFlag matches 1 \
    #     run scoreboard players set @s im_brittleNetDamage 0
    # execute \
    #     as @a \
    #     unless score @s im_brittleFlag matches 1 \
    #     run scoreboard players set @s im_brittleNetDamageAccum 0

    # Reset everyone's flag to 0 for the start of the next tick
    # scoreboard players set @a im_brittleFlag 0

# Process fishing rod damage on the exact tick it hooks; maybe unnecessary
    # execute \
    #     as @e[type=fishing_bobber,tag=!hook_processed] \
    #     if entity @n[type=!#im.not_mob,distance=0..0.1] \
    #     run function imperium:enchantments/barbs

# Chinks Curse Items
    # execute as @a[tag=im.chinks_curse] run function imperium:enchantments/chinks_calc
    # execute as @a[tag=im.had_chinks,tag=!im.chinks_curse] run function imperium:enchantments/chinks_remove

    # tag @a remove im.had_chinks
    # tag @a[tag=im.chinks_curse] add im.had_chinks
    # tag @a[tag=im.chinks_curse] remove im.chinks_curse