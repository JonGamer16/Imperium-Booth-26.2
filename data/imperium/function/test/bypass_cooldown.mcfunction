# Manual test: /function imperium:test/bypass_cooldown
# How does #minecraft:bypasses_cooldown damage (imperium:light) interact with the hurt cooldown?
# Each case hits a fresh 1000-HP pig (no armor, no AI) several times in ONE tick — the cooldown only
# counts down in entity ticks, so everything here lands inside a single cooldown window — then
# reports total HP lost. minecraft:generic is the "normal hit" (not in bypasses_cooldown).
#
# Hypotheses for a bypass hit:
#   H1  deals damage, does NOT start the cooldown
#   H2  deals full damage ignoring an active cooldown, leaves timer + threshold (lastHurt) alone
#   H3  deals full damage AND restarts the cooldown with its own amount as the new threshold

kill @e[type=minecraft:pig,tag=im.cdtest]
summon minecraft:pig ~2 ~ ~ {Tags:["im.cdtest","im.cdtest_0"],NoAI:1b,Silent:1b,attributes:[{id:"minecraft:max_health",base:1000.0}],Health:1000.0f}
summon minecraft:pig ~4 ~ ~ {Tags:["im.cdtest","im.cdtest_a"],NoAI:1b,Silent:1b,attributes:[{id:"minecraft:max_health",base:1000.0}],Health:1000.0f}
summon minecraft:pig ~6 ~ ~ {Tags:["im.cdtest","im.cdtest_b"],NoAI:1b,Silent:1b,attributes:[{id:"minecraft:max_health",base:1000.0}],Health:1000.0f}
summon minecraft:pig ~8 ~ ~ {Tags:["im.cdtest","im.cdtest_c"],NoAI:1b,Silent:1b,attributes:[{id:"minecraft:max_health",base:1000.0}],Health:1000.0f}

# 0 (control): normal 10, normal 5.  Vanilla: 10.00 (second hit ignored). Anything else = test invalid.
damage @n[tag=im.cdtest_0] 10 minecraft:generic
damage @n[tag=im.cdtest_0] 5 minecraft:generic

# A: bypass 1, then normal 1.  2.00 = bypass did NOT start a cooldown (H1).  1.00 = it did (H2/H3).
damage @n[tag=im.cdtest_a] 1 imperium:light
damage @n[tag=im.cdtest_a] 1 minecraft:generic

# B: normal 10, bypass 1, normal 5.
#   15.00 = bypass lowered the threshold to 1, so the 5 dealt 5-1=4 (H3).
#   11.00 = threshold stayed 10, the 5 was ignored (H2).   Bypass dealing <1 = it doesn't ignore the cooldown.
damage @n[tag=im.cdtest_b] 10 minecraft:generic
damage @n[tag=im.cdtest_b] 1 imperium:light
damage @n[tag=im.cdtest_b] 5 minecraft:generic

# C: the actual proposal — normal 10, bypass 0.0001, normal 5.  ~15.00 = works (H3).  ~10.00 = doesn't.
damage @n[tag=im.cdtest_c] 10 minecraft:generic
damage @n[tag=im.cdtest_c] 0.0001 imperium:light
damage @n[tag=im.cdtest_c] 5 minecraft:generic

# Report HP lost, in hundredths.
execute store result score #h0 im.temp run data get entity @n[tag=im.cdtest_0] Health 100
execute store result score #ha im.temp run data get entity @n[tag=im.cdtest_a] Health 100
execute store result score #hb im.temp run data get entity @n[tag=im.cdtest_b] Health 100
execute store result score #hc im.temp run data get entity @n[tag=im.cdtest_c] Health 100
scoreboard players set #full im.temp 100000
scoreboard players operation #full im.temp -= #h0 im.temp
scoreboard players operation #h0 im.temp = #full im.temp
scoreboard players set #full im.temp 100000
scoreboard players operation #full im.temp -= #ha im.temp
scoreboard players operation #ha im.temp = #full im.temp
scoreboard players set #full im.temp 100000
scoreboard players operation #full im.temp -= #hb im.temp
scoreboard players operation #hb im.temp = #full im.temp
scoreboard players set #full im.temp 100000
scoreboard players operation #full im.temp -= #hc im.temp
scoreboard players operation #hc im.temp = #full im.temp

tellraw @s {"text":"[cooldown test] HP lost x100","color":"gold"}
tellraw @s [{"text":" 0 control  10n,5n      : ","color":"gray"},{"score":{"name":"#h0","objective":"im.temp"},"color":"white"},{"text":"  (expect 1000)","color":"dark_gray"}]
tellraw @s [{"text":" A  1b,1n             : ","color":"gray"},{"score":{"name":"#ha","objective":"im.temp"},"color":"white"},{"text":"  (200 = H1, 100 = starts cooldown)","color":"dark_gray"}]
tellraw @s [{"text":" B  10n,1b,5n         : ","color":"gray"},{"score":{"name":"#hb","objective":"im.temp"},"color":"white"},{"text":"  (1500 = H3, 1100 = H2)","color":"dark_gray"}]
tellraw @s [{"text":" C  10n,0.0001b,5n    : ","color":"gray"},{"score":{"name":"#hc","objective":"im.temp"},"color":"white"},{"text":"  (~1500 = idea works, ~1000 = no)","color":"dark_gray"}]

kill @e[type=minecraft:pig,tag=im.cdtest]
