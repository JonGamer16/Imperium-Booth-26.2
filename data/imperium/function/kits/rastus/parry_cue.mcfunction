# AV cue for a successful Parry — reward of imperium:rastus_parry_cue, which earns when a
# player tagged im.rastus_parrying (the deflect window is open) is hit. Runs as/at the
# defender. Re-arm so a later deflect fires it again (parry_close also re-arms on expiry).
advancement revoke @s only imperium:rastus_parry_cue

# playsound minecraft:block.anvil.land     hostile @s ~ ~ ~ 0.4 1.9
# playsound minecraft:item.shield.block    player  @s ~ ~ ~ 1 1.6
# particle minecraft:electric_spark ~ ~1 ~ 0.3 0.3 0.3 0.18 26
# particle minecraft:crit           ~ ~1 ~ 0.4 0.4 0.4 0.20 16

playsound minecraft:entity.zombie.attack_iron_door player @s ~ ~ ~ 1 1.5
particle flash{color:-16580630} ~ ~1 ~ 0 0 0 1 1
particle minecraft:explosion ~ ~1 ~ 0 0 0 1 1