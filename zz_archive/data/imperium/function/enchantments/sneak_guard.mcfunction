execute as @s \
    run summon area_effect_cloud ~ ~ ~ \
    {ReapplicationDelay:1,Radius:0.5f,\
    RadiusOnUse:-1f,Duration:20,DurationOnUse:0,\
    Age:-1,WaitTime:0,\
    potion_contents:{custom_effects:\
    [{id:"minecraft:blindness",amplifier:0,duration:1}]}}