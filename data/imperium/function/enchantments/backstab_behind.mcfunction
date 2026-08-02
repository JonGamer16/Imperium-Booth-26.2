# @s = a human in front of the wielder (called from backstab.mcfunction; the wielder carries
# im.backstab_self). Arm the wielder's backstab if he stands BEHIND @s.
#
# The zone is a sphere of radius R centred R blocks behind @s, so it is TANGENT to @s's own
# position. That shape is self-correcting: it can never reach in front of the target, and it accepts
# an attacker at distance d, angle phi off "directly behind", exactly when  d <= 2*R*cos(phi).
# R is the only dial. R=3 -> 6 blocks straight back, and a 120-degree rear arc still open at 3
# blocks (melee reach). The old R=1.5 gave 3 blocks straight back, so at real melee spacing the
# accepted arc had narrowed almost to a line — a valid backstab a half-block off-axis missed.
#
# `at @s` takes @s's position + rotation, `rotated ~ 0` flattens pitch so a target looking up/down
# doesn't tilt the zone, `^ ^ ^-3` steps 3 blocks backward. Foot-anchored (see backstab.mcfunction:
# no `anchored eyes`), so R also absorbs the ~1.25 of height a jumping attacker gains. No NBT read.
execute at @s rotated ~ 0 positioned ^ ^ ^-3 as @a[tag=im.backstab_self,distance=..3] run scoreboard players set @s im_backstabflag 1
