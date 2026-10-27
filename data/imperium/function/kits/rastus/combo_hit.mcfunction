# Combo tax — a Rastus landed a hit (called from internal/reset_drought, the attack_player reward).
# Counts ATTACKS, not victims: the piercing rapier can hit several targets in one swing, and each
# fires attack_player, so im.combo_tick (cleared each tick in loop_kit) admits one count per tick.
# The window opens on the first hit and closes #ComboWindow ticks later (loop_kit), no dash spent.
# The #ComboHits-th hit inside it spends one dash and starts a fresh window.
execute if entity @s[tag=im.combo_tick] run return 0
tag @s add im.combo_tick

execute if score @s im_comboHits matches ..0 run scoreboard players set @s im_comboTimer 0
scoreboard players add @s im_comboHits 1
execute if score @s im_comboHits < #ComboHits im.param run return 0

# Combo limit reached: reset the window, then pay a dash if there is one. At 0 dashes the rapier is
# already slowed (combo_slow_on), which is the penalty, so there's nothing more to take.
scoreboard players set @s im_comboHits 0
scoreboard players set @s im_comboTimer 0
execute if score @s im_cdUsesC matches ..0 run return 0
scoreboard players remove @s im_cdUsesC 1
function imperium:kits/rastus/dash_count
playsound minecraft:entity.player.attack.nodamage player @s ~ ~ ~ 0.6 0.8
