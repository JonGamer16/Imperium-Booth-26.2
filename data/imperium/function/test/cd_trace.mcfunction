# Cooldown engine trace line, called from update_cooldowns when #CdTrace im_debug_mode is 1.
# Toggle with /function imperium:test/toggle_cd_trace. Prints what the engine sees for @s.
tellraw @s [{text:"[cd] ",color:"gold"},\
    {text:"dealt ",color:"gray"},{score:{name:"@s",objective:"im_abilityDealt"},color:"white"},\
    {text:" taken ",color:"gray"},{score:{name:"@s",objective:"im_abilityTaken"},color:"white"},\
    {text:" | A ",color:"gray"},{score:{name:"@s",objective:"im_abilityCdA"},color:"aqua"},\
    {text:" B ",color:"gray"},{score:{name:"@s",objective:"im_abilityCdB"},color:"aqua"},\
    {text:" C ",color:"gray"},{score:{name:"@s",objective:"im_abilityCdC"},color:"aqua"},\
    {text:" | uses/max/floor A ",color:"gray"},{score:{name:"@s",objective:"im_cdUsesA"}},{text:"/"},\
    {score:{name:"@s",objective:"im_cdMaxA"}},{text:"/"},{score:{name:"@s",objective:"im_cdFloorA"}},\
    {text:" B ",color:"gray"},{score:{name:"@s",objective:"im_cdUsesB"}},{text:"/"},\
    {score:{name:"@s",objective:"im_cdMaxB"}},{text:"/"},{score:{name:"@s",objective:"im_cdFloorB"}}]
