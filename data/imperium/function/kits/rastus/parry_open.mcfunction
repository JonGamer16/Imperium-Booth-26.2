# Open the parry's full-deflect bubble. Bounded to #ParryWindow ticks by im_parryWindow,
# which imperium:loop ticks down before calling parry_close to strip these back off.
# Resistance V = 100% damage cut; knockback_resistance +1.0 = 100% knockback negated.
scoreboard players operation @s im_parryWindow = #ParryWindow im.param
attribute @s minecraft:knockback_resistance modifier add imperium:parry 1.0 add_value
effect give @s minecraft:resistance 1 4 true

# Mark the open window so the rastus_parry_cue advancement can detect an incoming hit.
tag @s add im.rastus_parrying

playsound minecraft:block.shulker_box.open player JonGamer16 ~ ~ ~ 1 2
particle minecraft:enchanted_hit ~ ~1 ~ 0.3 0.3 0.3 1 20
particle block_marker{block_state:"redstone_block"}