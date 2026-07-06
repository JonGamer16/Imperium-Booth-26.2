# If a target is in range, Tipper is allowed to deal more damage
# 1. Preferably other entities don't count besides the one you hit
#    I would need vector coordinates to draw a straight line
#      in the direction the user is looking, so target selectors
# 2. Preferably other entities with tipper don't affect the user
#    This would happen if the system tagged the victim, but if I
#      make it based on the line the user is targeting and tag
#      them instead, that would fix the problem

# run the raycast
execute \
    as @s \
    at @s \
    anchored eyes \
    positioned ^ ^ ^ \
    run function imperium:enchantments/tipper_raycast

scoreboard players set @s im_tipper 1

execute \
    if score @s im_tipperdistance <= @s im_sourspot \
    run scoreboard players set @s im_tipper 0
# execute \
#    as @s[scores={im_tipperdistance=11..25}] \
#    run scoreboard players set @s im_tipper 1
execute \
    if score @s im_tipperdistance >= @s im_sweetspot \
    run scoreboard players set @s im_tipper 2