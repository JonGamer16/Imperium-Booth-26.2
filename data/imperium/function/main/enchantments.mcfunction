# ENCHANTMENTS
scoreboard objectives add tempDamage custom:damage_dealt
scoreboard objectives add im_rotation dummy
scoreboard objectives add im_rotationdiff dummy

#   Backstab (im_backstabraycast removed — the step-counter raycast is gone, replaced by sphere checks)
    scoreboard objectives add im_backstabflag dummy
    scoreboard objectives add im_backstabtracking dummy
#   High Jump
    scoreboard objectives add im_high_jump dummy
    scoreboard objectives add im_high_jump_eq dummy
#   Ability cooldowns (im.dmg = cooldown length unit, see ability_cooldowns.mcfunction; im.max = charge cap)
    scoreboard objectives add im.dmg dummy
    scoreboard objectives add im.max dummy
#   Life Steal (damage dealt -> soup)
    scoreboard objectives add im_lsDealt custom:damage_dealt
    scoreboard objectives add im_lsPrev dummy
    scoreboard objectives add im_lsDelta dummy
    scoreboard objectives add im_lsFlag dummy
    scoreboard objectives add im_lifesteal dummy
