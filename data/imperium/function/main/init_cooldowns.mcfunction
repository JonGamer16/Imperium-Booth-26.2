# Net Damage Tracking (delta inputs that bleed the cooldowns)
scoreboard objectives add im_abilityDealt custom:damage_dealt
scoreboard objectives add im_abilityTaken custom:damage_taken

# Ability Cooldowns
scoreboard objectives add im_abilityCdA dummy
scoreboard objectives add im_abilityCdB dummy
scoreboard objectives add im_abilityCdC dummy
#   Remaining charges per slot. 0 = fully spent (cooldown counts down); >0 = frozen.
#   Unwired slots stay 0 and keep the old always-counting behavior.
scoreboard objectives add im_cdUsesA dummy
scoreboard objectives add im_cdUsesB dummy
scoreboard objectives add im_cdUsesC dummy
#   Max Ability Charges
scoreboard objectives add im_cdMaxA dummy
scoreboard objectives add im_cdMaxB dummy
scoreboard objectives add im_cdMaxC dummy
#   Stockpile %: how much of a cooldown may pre-charge while still frozen (per kit/slot).
#   Floor = base*(100-stock)/100: the value a frozen slot can bleed down to (banking residual).
scoreboard objectives add im_cdStockA dummy
scoreboard objectives add im_cdStockB dummy
scoreboard objectives add im_cdStockC dummy
scoreboard objectives add im_cdFloorA dummy
scoreboard objectives add im_cdFloorB dummy
scoreboard objectives add im_cdFloorC dummy

# Populate per-kit cooldown bases, stockpile %s, floors, and charges.
# (Requires the constants from main/constants to already be declared.)
function imperium:main/ability_cooldowns
