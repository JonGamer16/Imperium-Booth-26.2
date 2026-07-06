# Per-Mummy per-tick logic — called `as @s at @s` from imperium:loop (one walk over Mummy players).
# Energy first so the Golem wind-up reads the barrier-synced pool.
function imperium:kits/mummy/energy_tick

# Golem Throw: a charged heavy hit wound up ONLY while sneaking (same hold as the Energy Barrier).
# The charge drives a cycle: [#GolemChargeTime, #GolemChargeEnd) is the ARMED window; miss it and it
# resets. Armed (im_golemReady=1) also needs enough energy. Releasing sneak resets the wind-up.
execute if predicate imperium:sneaking run scoreboard players add @s im_golemCharge 1
execute unless predicate imperium:sneaking run scoreboard players set @s im_golemCharge 0
execute if score @s im_golemCharge >= #GolemChargeEnd im.param run scoreboard players set @s im_golemCharge 0
scoreboard players set @s im_golemReady 0
execute if predicate imperium:sneaking if score @s im_golemCharge >= #GolemChargeTime im.param if score @s im_energy >= #MummyGolemThrowCost im.param run scoreboard players set @s im_golemReady 1
execute if entity @s[tag=!im.golem_armed] if score @s im_golemReady matches 1 run function imperium:kits/mummy/golem_arm
execute if entity @s[tag=im.golem_armed] if score @s im_golemReady matches 0 run function imperium:kits/mummy/golem_disarm
# While armed, particles telegraph the wind-up to nearby enemies.
execute if entity @s[tag=im.golem_armed] run particle minecraft:crit ~ ~1 ~ 0.4 0.7 0.4 0.1 6
execute if entity @s[tag=im.golem_armed] run particle minecraft:electric_spark ~ ~1 ~ 0.4 0.8 0.4 0.02 6
