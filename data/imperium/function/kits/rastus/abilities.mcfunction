# Rastus kit abilities — called by kit_dispatch when any im_abilityCd* reaches 0
execute \
    if score @s im_abilityCdA matches 0 \
    run function imperium:kits/rastus/cd1_shield
