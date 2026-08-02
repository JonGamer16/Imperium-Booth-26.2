# Backstab arming — arm im_backstabflag when the wielder is attacking a target from behind. Runs
# every tick via the enchant's tick effect.
#
# OPTIMIZED (no NBT): the old version read both entities' Rotation[0] with `data get entity`, which
# serializes the WHOLE entity NBT (a player's entire inventory) — the 1ms -> 8ms spike. This reads
# no NBT: it uses `rotated as`/`rotated` to apply facings engine-side. Two conditions, so it can tell
# a target you're behind from one that's merely nearby:
#   1) the target is IN FRONT of the wielder (the one he's swinging at)  -- this file, wielder facing
#   2) the wielder is BEHIND the target (its back toward him)            -- backstab_behind, target facing
#
# Both zones are FEET-anchored spheres — never `anchored eyes`. `distance=` measures to an entity's
# feet, so an eye-height centre bakes a ~1.62 vertical offset into every check; a jump (+1.25 at
# apex) then pushes a target past the radius on its own, meaning jump/crit attacks could never arm
# the flag. That was most of "backstab doesn't work".

# Throttle to every other tick (position barely moves in 0.1s). im_backstabtracking is the counter.
scoreboard players add @s im_backstabtracking 1
execute if score @s im_backstabtracking matches 2.. run scoreboard players set @s im_backstabtracking 0
execute unless score @s im_backstabtracking matches 0 run return 0

# Clear last recompute's result (so a stale "armed" never lingers).
scoreboard players set @s im_backstabflag 0

# Tag the wielder so the scan excludes him and backstab_behind can find him back.
tag @s add im.backstab_self

# Candidates = humans in front of the wielder (sphere r=2.5 centred 2 blocks ahead along his
# flattened facing, at foot level: reaches ~4.5 ahead, ~2.1 to the side, ~2.5 up/down). For each,
# backstab_behind arms only if he's also behind it — that's the test that actually decides, so an
# over-generous front zone is fine, extras get filtered there.
execute at @s rotated ~ 0 positioned ^ ^ ^2.0 as @e[type=#imperium:human,tag=!im.backstab_self,distance=..2.5] run function imperium:enchantments/backstab_behind

tag @s remove im.backstab_self
