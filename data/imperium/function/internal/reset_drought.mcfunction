scoreboard players set @s im_melee_drought 0
execute if entity @s[tag=im.kit_rastus] run function imperium:kits/rastus/combo_hit
advancement revoke @s only imperium:attack_player