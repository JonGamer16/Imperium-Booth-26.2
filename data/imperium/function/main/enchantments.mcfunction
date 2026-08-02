# ENCHANTMENTS
scoreboard objectives add im_tempDamage custom:damage_dealt

#   Backstab (rotation reads gone — arming is now a `rotated as <target>` behind-zone check, no NBT)
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
#   Life Steal escalation: soups converted this life, and the resulting cost of the NEXT soup
#   (#lsThreshold + #lsStep * conversions). im_lsNeed is cached rather than recomputed per tick —
#   it only changes on a conversion (lifesteal_soup) or a re-kit (livvy/givekit).
    scoreboard objectives add im_lsConversions dummy
    scoreboard objectives add im_lsNeed dummy
