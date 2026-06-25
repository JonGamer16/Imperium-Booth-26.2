# Parry — reward of imperium:raise_shield (fires as @s = a Rastus player who raised his
# buckler). Strike & Parry share one charge: im_melee_drought = idle ticks since the last
# melee hit (attack_player resets it on a landed hit; here, raising the shield resets it too,
# so "0.6s without attacking OR blocking" is enforced). A raise while charged (>= #StrikeCharge)
# opens a brief full-deflect bubble; any raise spends the charge.

# Re-arm so the next raise (or the next tick of holding) fires this again.
advancement revoke @s only imperium:raise_shield

# Charged at the instant of the raise -> open the full-deflect window.
execute if score @s im_melee_drought >= #StrikeCharge im.param \
    run function imperium:kits/rastus/parry_open

# Raising counts as acting: spend the charge so a mistimed raise wastes it and holding the
# shield can never farm parries. Re-charging needs #StrikeCharge idle ticks again.
scoreboard players set @s im_melee_drought 0