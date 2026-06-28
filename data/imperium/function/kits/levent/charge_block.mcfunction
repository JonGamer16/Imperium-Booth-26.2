# Shield raised — reward of imperium:levent_shield (fires as @s = a Levent who raised his shield).
# Raising counts as acting: zero the charge so "no attacking OR shielding" is enforced, then
# re-arm the advancement so the next raise (or the next tick of holding) fires this again. This
# keeps the charge pinned at 0 for as long as the shield stays up.
scoreboard players set @s im_leventCharge 0
advancement revoke @s only imperium:levent_shield
