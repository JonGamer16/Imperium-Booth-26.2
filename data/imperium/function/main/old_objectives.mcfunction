# Legacy objectives from the pre-ability-system item/refill design.
# Kept declared so old functions referencing them don't error; remove once retired.

# Damage Based Refill Items
scoreboard objectives add rArrow dummy
scoreboard objectives add rBlazePowder dummy
scoreboard objectives add rBoat dummy
scoreboard objectives add rGravityArrow dummy
scoreboard objectives add rHarmPot dummy
scoreboard objectives add rJumpPot dummy
scoreboard objectives add rPearl dummy
scoreboard objectives add rPoisonArrow dummy
scoreboard objectives add rShield dummy
scoreboard objectives add rSlowPot dummy
scoreboard objectives add rTotem dummy
scoreboard objectives add rTrident2 dummy
scoreboard objectives add rWindCharge dummy

# Kill Based Refill Items
scoreboard objectives add rGoldArmor dummy
scoreboard objectives add rTrident dummy

# Healing items
scoreboard objectives add rBeetSoup dummy
scoreboard objectives add rMushSoup dummy
scoreboard objectives add rRabbitSoup dummy
scoreboard objectives add rCraftSoup dummy

scoreboard objectives add rCake dummy
scoreboard objectives add rEnergyCrystal dummy
scoreboard objectives add rGapple dummy
scoreboard objectives add rHeal2Pot dummy
scoreboard objectives add rRegenPot dummy
scoreboard objectives add rSalmon dummy

# Item reloads
scoreboard objectives add itemreload custom:damage_dealt

# Player Progression
scoreboard objectives add highestDamageRecord dummy
scoreboard objectives add totalDamage custom:damage_dealt
scoreboard objectives add gold dummy
scoreboard objectives add silver dummy
scoreboard objectives add damageThisLife custom:damage_dealt
scoreboard objectives add totalKills playerKillCount
scoreboard objectives add totalDeaths deathCount
