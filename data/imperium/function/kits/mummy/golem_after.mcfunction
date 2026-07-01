# Golem Throw spent — runs as the ATTACKER after a charged hit lands (wip_golem_throw post_attack,
# affected=attacker, gated on im_golemReady). Ordered AFTER the victim-launch entry so clearing the
# armed flag here can't cancel that entry. Pay the energy; the Energy Barrier is always up during a
# throw (you charge while sneaking), so re-project it onto the absorption hearts — otherwise the hold
# sync would read the unchanged hearts next tick and refund the spend. Then reset the wind-up + disarm.
scoreboard players operation @s im_energy -= #MummyGolemThrowCost im.param
execute if score @s im_energy matches ..0 run scoreboard players set @s im_energy 0
execute if entity @s[tag=im.barrier_up] run function imperium:kits/mummy/barrier_apply

scoreboard players set @s im_golemCharge 0
scoreboard players set @s im_golemReady 0
tag @s remove im.golem_armed

playsound minecraft:item.mace.smash_ground player @a[distance=..32] ~ ~ ~ 1.2 0.8
