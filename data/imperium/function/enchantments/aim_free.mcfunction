# Kill @s's paired crosshair-tracker interaction (see aim_bind). Runs as the player from
# on_death, end_round (arena leave), and clear_kit (kit swap) — the un-bind lets aim_tick
# re-summon a fresh tracker the next time the enchanted weapon is held.
execute unless entity @s[tag=im.aim_bound] run return 0

scoreboard players operation #free im_aimId = @s im_aimId
execute as @e[type=interaction,tag=im.aim] if score @s im_aimId = #free im_aimId run kill @s

tag @s remove im.aim_bound
say aim_free