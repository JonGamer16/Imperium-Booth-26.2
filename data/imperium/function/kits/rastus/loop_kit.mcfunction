# Per-Rastus per-tick logic — called `as @s at @s` from imperium:loop.

# Superior Agility: air dodge is advancement-driven; re-arm it on the ground so each airtime gets
# exactly one dodge.
execute if predicate imperium:on_ground run advancement revoke @s only imperium:rastus_air_dodge

# Strike & Parry shared charge = idle ticks since the last melee (reset by a landed hit / shield raise).
scoreboard players add @s im_melee_drought 1

# Parry full-deflect bubble: tick the window down; when it closes, strip Resistance/KB resist.
execute if score @s im_parryWindow matches 1.. run scoreboard players remove @s im_parryWindow 1
execute if score @s im_parryWindow matches 0 run function imperium:kits/rastus/parry_close

# Strike: arm the rapier boost the tick the shared charge completes; strip it once the charge is gone.
execute if entity @s[tag=!im.rastus_focused] if score @s im_melee_drought >= #StrikeCharge im.param run function imperium:kits/rastus/focus_on
execute if entity @s[tag=im.rastus_focused] unless score @s im_melee_drought >= #StrikeCharge im.param run function imperium:kits/rastus/focus_off
