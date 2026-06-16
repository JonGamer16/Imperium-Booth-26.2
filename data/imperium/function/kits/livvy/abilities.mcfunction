# Livvy kit abilities — called by kit_dispatch when any im_abilityCd* reaches 0
# TODO: Implement livvy kit abilities here
# Each ability should reset its cooldown when it fires, e.g.:
#   scoreboard players set @s im_abilityCdA <damage_units>
# Placeholder: resets all cooldowns to prevent continuous firing during development
execute \
    if score @s im_abilityCdA matches ..0 \
    run function imperium:kits/livvy/cd1_feather
execute \
    if score @s im_abilityCdB matches ..0 \
    run function imperium:kits/livvy/cd2_web
execute \
    if score @s im_abilityCdC matches ..0 \
    run function imperium:kits/livvy/cd3_potion