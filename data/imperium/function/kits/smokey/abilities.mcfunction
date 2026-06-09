# Smokey kit abilities — called by kit_dispatch when any im_abilityCd* reaches 0
execute \
    if score @s im_abilityCdA matches 0 \
    run function imperium:kits/smokey/cd1_rod
execute \
    if score @s im_abilityCdB matches 0 \
    run function imperium:kits/smokey/cd2_arrow
execute \
    if score @s im_abilityCdC matches 0 \
    run function imperium:kits/smokey/cd3_potion
