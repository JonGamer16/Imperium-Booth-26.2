# Float a "-<dmg>" label above the dummy (runs AS/AT the husk; #drop = this hit in tenths of a HP).
# Split into whole.frac for a "-6.5"-style number, stage both into storage, and macro-summon the
# text_display so the number is baked in as literal text — a live score component would get
# overwritten by the next hit before the label expires.
scoreboard players operation #whole im.temp = #drop im.temp
scoreboard players operation #whole im.temp /= #10 imperium.const
scoreboard players operation #frac im.temp = #drop im.temp
scoreboard players operation #frac im.temp %= #10 imperium.const
execute store result storage imperium:dummy ind.whole int 1 run scoreboard players get #whole im.temp
execute store result storage imperium:dummy ind.frac int 1 run scoreboard players get #frac im.temp
function imperium:booth/dummy/dmg_spawn with storage imperium:dummy ind

# Arm the freshly spawned label: ~0.6s lifetime (aged/risen/killed in imperium:loop_tick), then
# drop the one-shot setup tag so the next hit's set doesn't touch it.
scoreboard players set @e[type=text_display,tag=im.dmg_new] im_indLife 12
tag @e[type=text_display,tag=im.dmg_new] remove im.dmg_new
