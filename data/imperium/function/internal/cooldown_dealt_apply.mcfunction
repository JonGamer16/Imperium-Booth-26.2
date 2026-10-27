# Deferred half of the dealt trigger, as the attacking player (see internal/cooldown_dealt).
# Non-human hits charge 1/3: scale the settled dealt damage before the engine consumes it.
# im_abilityDealt is in tenths of HP, so the floor division loses at most 0.2 HP per hit.
execute if score #CdTrace im_debug_mode matches 1 if entity @s[tag=im.cd_hit_human] run tellraw @s {text:"[cd] flush: human hit, dealt x1",color:"gold"}
execute if score #CdTrace im_debug_mode matches 1 unless entity @s[tag=im.cd_hit_human] run tellraw @s {text:"[cd] flush: non-human hit, dealt /3",color:"gold"}
execute unless entity @s[tag=im.cd_hit_human] run scoreboard players operation @s im_abilityDealt /= #3 imperium.const
function imperium:update_cooldowns

# Gold scoring stays arena-only and human-only (it was only ever reached on human hits): ability_zone
# also passes in the booth, and without the im.fighting guard whacking the training dummy would print
# "[Damage Bonus] +N Gold" and bank match score.
execute if entity @s[tag=im.cd_hit_human,tag=im.fighting] run function imperium:arena/gold_dmg_bonus

tag @s remove im.cd_dealt_pending
tag @s remove im.cd_hit_human
