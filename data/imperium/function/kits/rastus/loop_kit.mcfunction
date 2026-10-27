# Per-Rastus per-tick logic — called `as @s at @s` from imperium:loop.

# Superior Agility: the air dodge used to be re-armed here on landing, which is what made it
# once-per-airtime. Its cooldown is now the shared Strike & Parry charge (see kits/rastus/air_dodge),
# and every path through that function revokes for itself, so the landing revoke had nothing left to
# do — a per-tick on_ground predicate for every Rastus, removed.

# Strike & Parry shared charge = idle ticks since the last melee (reset by a landed hit / shield raise).
scoreboard players add @s im_melee_drought 1

# Combo tax (see combo_hit): re-open the one-count-per-tick gate, age the open window, and close it
# with no dash spent once #ComboWindow ticks pass.
tag @s remove im.combo_tick
execute if score @s im_comboHits matches 1.. run scoreboard players add @s im_comboTimer 1
execute if score @s im_comboHits matches 1.. if score @s im_comboTimer >= #ComboWindow im.param run scoreboard players set @s im_comboHits 0

# Rapier slowdown at 0 dashes: edge-triggered off the dash count, which several places change
# (air_dodge, cd3_dodge, combo_hit, givekit), so watching the count here covers all of them.
execute if score @s im_cdUsesC matches ..0 if entity @s[tag=!im.rastus_slowed] run function imperium:kits/rastus/combo_slow_on
execute if score @s im_cdUsesC matches 1.. if entity @s[tag=im.rastus_slowed] run function imperium:kits/rastus/combo_slow_off

# Parry full-deflect bubble: tick the window down; when it closes, strip Resistance/KB resist.
execute if score @s im_parryWindow matches 1.. run scoreboard players remove @s im_parryWindow 1
execute if score @s im_parryWindow matches 0 run function imperium:kits/rastus/parry_close

# Strike: arm the rapier boost the tick the shared charge completes; strip it once the charge is gone.
execute if entity @s[tag=!im.rastus_focused] if score @s im_melee_drought >= #StrikeCharge im.param run function imperium:kits/rastus/focus_on
execute if entity @s[tag=im.rastus_focused] unless score @s im_melee_drought >= #StrikeCharge im.param run function imperium:kits/rastus/focus_off
