# @s = a human in front of the wielder (called from backstab.mcfunction; the wielder carries
# im.backstab_self). Arm the wielder's backstab if he stands BEHIND @s — i.e. within the zone off
# @s's own back. `at @s` resets to @s's position + rotation, `rotated ~ 0` flattens pitch so a
# looking-up/down target doesn't tilt the zone, `^ ^ ^-1.5` steps 1.5 blocks backward. No NBT read.
execute at @s rotated ~ 0 positioned ^ ^ ^-1.5 if entity @a[tag=im.backstab_self,distance=..1.5] run scoreboard players set @a[tag=im.backstab_self] im_backstabflag 1
