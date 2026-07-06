# Get Temper Level
execute \
    store result score @s im_temperlevel \
    run data get entity @s \
        SelectedItem.components.minecraft:enchantments.imperium:temper 1
# Get Current HP (x50)
execute \
    store result score @s im_hp \
    run data get entity @s \
        Health 50
# Get Max HP (x50)
execute \
    store result score @s im_maxhp \
    run data get entity @s \
        attributes[{id:"minecraft:max_health"}].base 50
# Missing HP = Max HP - Current HP (x50) 
execute \
    store result score @s im_missinghp \
    run scoreboard players operation @s im_maxhp -= @s im_hp
# Temper Buff = Missing HP * Temper Level (x50)
execute \
    store result score @s im_temperinitialmodif \
    run scoreboard players operation @s im_missinghp *= @s im_temperlevel

# Get Player Base Attack Damage (x100)
execute \
    store result score @s im_temperinitialdmg \
    run data get entity @s SelectedItem.components."minecraft:attribute_modifiers"[{id:"imperium:temper"}]

# Get Temper Enchantment Level
execute \
    store result score @s im_temperlevel \
    run data get entity @s \
        SelectedItem.components.minecraft:enchantments.imperium:temper 1
execute \
    store result score @s im_temperlevel \
    run scoreboard players operation @s im_temperlevel += const 1

# Whole-number percent (e.g. 12 from 12.34%)
scoreboard players operation @s im_temperwhole = @s im_temperinitialmodif
scoreboard players operation @s im_temperwhole /= const 1000

# One-digit decimal portion (e.g. 3 from 12.34%)
scoreboard players operation @s im_temperdecimal = @s im_temperinitialmodif
scoreboard players operation @s im_temperdecimal %= const 1000
scoreboard players operation @s im_temperdecimal /= const 100

# Convert to a macro-readable format
    # 1. Store the whole number score into a temporary NBT storage object
    execute \
        store result storage imperium:temp_data temper.whole int 1 \
        run scoreboard players get @s im_temperwhole

    # 2. Store the decimal score into the same NBT storage object
    execute \
        store result storage imperium:temp_data temper.decimal int 1 \
        run scoreboard players get @s im_temperdecimal

    # 3. Call the macro function using that specific storage path
    execute \
        at @s \
        run function imperium:enchantments/temper_update with storage imperium:temp_data temper

# $execute as @s \
#     store result storage imperium:player_data players."$(player_name)".TemperWhole int 1 \
#     run scoreboard players get @s im_temperwhole
# $execute as @s \
#     store result storage imperium:player_data players."$(player_name)".TemperDecimal int 1 \
#     run scoreboard players get @s im_temperdecimal



# $execute as @s \
#     run function imperium:enchantments/temper_damage with storage imperium:player_data players."$(player_name)"

# Initial Modifier = Temper Buff / 200
# execute \
#     store result score @s im_temperbuff \
#     run \
#         scoreboard players operation @s im_temperbuff /= const 200

# I have the temper buff now, it's level * missing health * 100
    # Temper 5 with 5 missing health = 25000
    # I need to convert this to +12.5% damage
# For initial damage, I need to get the player's attack damage
# Then multiply the damage by the temper buff / 200
# im_temperwhole = im_temperbuff / 200
# im_temperdecimal = (im_temperbuff % 200) / 20
# Once I get that figured out, I need to figure out how to add the damage modifier
# I need to add a modifier with a unique ID, and then remove it when the player switches items or dies

# Now compute the reported percent increase and final damage.
#
# im_temperinitialmodif currently contains: (missingHP * level * 100)
# - missingHP was stored with a multiplier of 100 (i.e. missingHP * 100)
# - multiplying by level gives: level * missingHP * 100
#
# That value is the percent expressed in hundredths (e.g. 12.34% => 1234).
# So:
#  - whole percent = floor(percent_hundredths / 100)
#  - decimal (two-digit) = percent_hundredths % 100


# -- Optional: compute the actual damage values using integer math.
# im_temperinitialdmg currently holds the player's base attack damage scaled by 100
# (see earlier attribute get with multiplier 100). To compute the damage increase:
# percent_hundredths = im_temperinitialmodif
# damage_increase = base_damage * ercent / 100
# with integer scaling: (base_damage*100) * percent_hundredths / 10000

# damage increase (scaled like base damage, i.e. x100)
# scoreboard players operation @s im_temperbuff = @s im_temperinitialdmg
# scoreboard players operation @s im_temperbuff *= @s im_temperinitialmodif
# scoreboard players operation @s im_temperbuff /= const 10000

# final damage (base + increase), still scaled by 100
# scoreboard players operation @s im_temperfinaldmg = @s im_temperinitialdmg
# scoreboard players operation @s im_temperfinaldmg += @s im_temperbuff

# split final damage into whole number and decimal
# scoreboard players operation @s im_temperfinalwhole = @s im_temperfinaldmg
# scoreboard players operation @s im_temperfinalwhole /= const 100

# scoreboard players operation @s im_temperfinaldecimal = @s im_temperfinaldmg
# scoreboard players operation @s im_temperfinaldecimal %= const 100

    # execute as @s run attribute @s minecraft:attack_damage modifier remove temper

    # execute \
    #     as @s \
    #     store result \
    #     attribute @s minecraft:attack_damage modifier add temper "Temper Bonus" 0 add_value \
    #     run scoreboard players get @s im_temper_scaled


# im_temperwhole now contains the whole percent, im_temperdecimal the two-digit
# fractional part (nearest hundredth). im_temperfinaldmg is the new damage (x100).