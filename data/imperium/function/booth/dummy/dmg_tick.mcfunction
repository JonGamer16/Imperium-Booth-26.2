# Training-dummy damage sampler — runs once per tick per dummy husk, AS the husk, AT the husk
# (see the call in imperium:loop_tick). The husk has NO regen (see respawn), so its only health
# increases are the periodic heal-to-full below; every health DROP is therefore exactly one hit's
# damage. Health x10 keeps 0.1-HP precision as an integer.
execute store result score #hp im.temp run data get entity @s Health 10
scoreboard players operation #drop im.temp = @s im_hpPrev
scoreboard players operation #drop im.temp -= #hp im.temp
scoreboard players operation @s im_hpPrev = #hp im.temp

# A drop of >= 0.1 HP is a hit: float the number and reset the no-hit counter. Otherwise count up.
execute if score #drop im.temp matches 1.. run function imperium:booth/dummy/dmg_show
execute if score #drop im.temp matches 1.. run scoreboard players set @s im_dmgLull 0
execute unless score #drop im.temp matches 1.. run scoreboard players add @s im_dmgLull 1

# Quiet for 2s (40t) -> top the husk back up to full. Can't fall on a hit tick (a hit zeroes the
# counter), so it never masks damage. Cheap no-op when already full.
execute if score @s im_dmgLull matches 40.. run function imperium:booth/dummy/dmg_heal
