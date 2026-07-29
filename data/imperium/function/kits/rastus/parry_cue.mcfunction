# AV cue for a successful Parry — reward of imperium:rastus_parry_cue, which earns when a
# player tagged im.rastus_parrying (the deflect window is open) is hit. Runs as/at the
# defender. Re-arm so a later deflect fires it again (parry_close also re-arms on expiry).
advancement revoke @s only imperium:rastus_parry_cue

playsound minecraft:entity.zombie.attack_iron_door player @s ~ ~ ~ 1 1.5
particle flash{color:-16580630} ~ ~1 ~ 0 0 0 1 1
particle minecraft:explosion ~ ~1 ~ 0 0 0 1 1