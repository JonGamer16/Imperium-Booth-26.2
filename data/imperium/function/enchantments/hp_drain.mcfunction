#say hp_drain

execute as @s[scores={itemreload=20..39}] run \
    summon area_effect_cloud ~ ~ ~ \
    {ReapplicationDelay:1,Radius:0.5f,\
    RadiusOnUse:-1f,Duration:20,DurationOnUse:0,\
    Age:-1,WaitTime:0,\
    potion_contents:{custom_effects:\
    [{id:"minecraft:regeneration",amplifier:11,duration:1}]}}
execute as @s[scores={itemreload=20..39}] run \
    scoreboard players remove @s itemreload 20

execute as @s[scores={itemreload=40..59}] run \
    summon area_effect_cloud ~ ~ ~ \
    {ReapplicationDelay:1,Radius:0.5f,\
    RadiusOnUse:-1f,Duration:20,DurationOnUse:0,\
    Age:-1,WaitTime:0,\
    potion_contents:{custom_effects:\
    [{id:"minecraft:regeneration",amplifier:11,duration:2}]}}
execute as @s[scores={itemreload=40..59}] run \
    scoreboard players remove @s itemreload 40

execute as @s[scores={itemreload=60..79}] run \
    summon area_effect_cloud ~ ~ ~ \
    {ReapplicationDelay:1,Radius:0.5f,\
    RadiusOnUse:-1f,Duration:20,DurationOnUse:0,\
    Age:-1,WaitTime:0,\
    potion_contents:{custom_effects:\
    [{id:"minecraft:regeneration",amplifier:11,duration:3}]}}
execute as @s[scores={itemreload=60..79}] run \
    scoreboard players remove @s itemreload 60

execute as @s[scores={itemreload=80..99}] run \
    summon area_effect_cloud ~ ~ ~ \
    {ReapplicationDelay:1,Radius:0.5f,\
    RadiusOnUse:-1f,Duration:20,DurationOnUse:0,\
    Age:-1,WaitTime:0,\
    potion_contents:{custom_effects:\
    [{id:"minecraft:regeneration",amplifier:11,duration:4}]}}
execute as @s[scores={itemreload=80..99}] run \
    scoreboard players remove @s itemreload 80

execute as @s[scores={itemreload=100..119}] run \
    summon area_effect_cloud ~ ~ ~ \
    {ReapplicationDelay:1,Radius:0.5f,\
    RadiusOnUse:-1f,Duration:20,DurationOnUse:0,\
    Age:-1,WaitTime:0,\
    potion_contents:{custom_effects:\
    [{id:"minecraft:regeneration",amplifier:11,duration:5}]}}
execute as @s[scores={itemreload=100..119}] run \
    scoreboard players remove @s itemreload 100

execute as @s[scores={itemreload=120..139}] run \
    summon area_effect_cloud ~ ~ ~ \
    {ReapplicationDelay:1,Radius:0.5f,\
    RadiusOnUse:-1f,Duration:20,DurationOnUse:0,\
    Age:-1,WaitTime:0,\
    potion_contents:{custom_effects:\
    [{id:"minecraft:regeneration",amplifier:11,duration:6}]}}
execute as @s[scores={itemreload=120..139}] run \
    scoreboard players remove @s itemreload 120

execute as @s[scores={itemreload=140..159}] run \
    summon area_effect_cloud ~ ~ ~ \
    {ReapplicationDelay:1,Radius:0.5f,\
    RadiusOnUse:-1f,Duration:20,DurationOnUse:0,\
    Age:-1,WaitTime:0,\
    potion_contents:{custom_effects:\
    [{id:"minecraft:regeneration",amplifier:11,duration:7}]}}
execute as @s[scores={itemreload=140..159}] run \
    scoreboard players remove @s itemreload 140

execute as @s[scores={itemreload=160..179}] run \
    summon area_effect_cloud ~ ~ ~ \
    {ReapplicationDelay:1,Radius:0.5f,\
    RadiusOnUse:-1f,Duration:20,DurationOnUse:0,\
    Age:-1,WaitTime:0,\
    potion_contents:{custom_effects:\
    [{id:"minecraft:regeneration",amplifier:11,duration:8}]}}
execute as @s[scores={itemreload=160..179}] run \
    scoreboard players remove @s itemreload 160

execute as @s[scores={itemreload=180..199}] run \
    summon area_effect_cloud ~ ~ ~ \
    {ReapplicationDelay:1,Radius:0.5f,\
    RadiusOnUse:-1f,Duration:20,DurationOnUse:0,\
    Age:-1,WaitTime:0,\
    potion_contents:{custom_effects:\
    [{id:"minecraft:regeneration",amplifier:11,duration:9}]}}
execute as @s[scores={itemreload=180..199}] run \
    scoreboard players remove @s itemreload 180

execute as @s[scores={itemreload=200..}] run \
    summon area_effect_cloud ~ ~ ~ \
    {ReapplicationDelay:1,Radius:0.5f,\
    RadiusOnUse:-1f,Duration:20,DurationOnUse:0,\
    Age:-1,WaitTime:0,\
    potion_contents:{custom_effects:\
    [{id:"minecraft:regeneration",amplifier:11,duration:10}]}}
execute as @s[scores={itemreload=200..}] run \
    scoreboard players remove @s itemreload 200
