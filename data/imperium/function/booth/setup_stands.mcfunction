# One-shot: (re)build a test row of all seven kit-selection stands.
# Clears any existing booth stands first so re-running never duplicates them, then
# places the seven kits spaced 3 blocks apart along +X starting at your feet.
kill @e[type=interaction,tag=im.booth_stand,limit=9]
kill @e[type=armor_stand,tag=im.booth_stand_model,limit=9]

execute positioned ~ ~ ~ run function imperium:kits/cliffshield/booth/summon
execute positioned ~ ~ ~-3 run function imperium:kits/rastus/booth/summon
execute positioned ~ ~ ~-6 run function imperium:kits/livvy/booth/summon
execute positioned ~ ~ ~-9 run function imperium:kits/mummy/booth/summon
execute positioned ~2 ~ ~-11 run function imperium:kits/levent/booth/summon
execute positioned ~5 ~ ~-11 run function imperium:kits/smokey/booth/summon
execute positioned ~8 ~ ~-11 run function imperium:kits/meowdy/booth/summon

# Utility stands: random kit + clear kit (interactions only, no display model)
execute positioned ~4.75 ~-0.625 ~2.5 run function imperium:booth/random/summon
execute positioned ~6.5 ~-0.625 ~-5.25 run function imperium:booth/clear/summon
