execute \
    as @s \
    if entity @s[predicate=imperium:sneaking] \
    run scoreboard players add @s im_powersmash 1

execute \
    as @s \
    if entity @s[predicate=!imperium:sneaking,scores={im_powersmash=0..}] \
    run scoreboard players reset @s im_powersmash

execute \
    as @s[scores={im_powersmash=1..}] \
    run title @s times 0 20 0
execute \
    as @s[scores={im_powersmash=1..9}] \
    run title @s subtitle \
        [{"text":"\\u25cf ","underlined":true,"color":"dark_blue"},\
        {"text":"\\u25cf ","underlined":true,"color":"dark_blue"},\
        {"text":"\\u25cf ","underlined":true,"color":"dark_blue"},\
        {"text":"\\u2b24","underlined":true,"color":"dark_blue"}]

execute \
    as @s[scores={im_powersmash=10}] \
    run playsound block.note_block.chime player @s ~ ~ ~ 1 0.595
execute \
    as @s[scores={im_powersmash=10..19}] \
    run title @s subtitle \
        [{"text":"\\u25cf ","underlined":true,"color":"green"},\
        {"text":"\\u25cf ","underlined":true,"color":"dark_blue"},\
        {"text":"\\u25cf ","underlined":true,"color":"dark_blue"},\
        {"text":"\\u2b24","underlined":true,"color":"dark_blue"}]
# [{"text":"\u25cf","underlined":true,"color":"green"},{"text":"\u25cf","underlined":true,"color":"dark_blue"},{"text":"\u25cf","underlined":true,"color":"dark_blue"},{"text":"\u2b24","underlined":true,"color":"dark_blue"}]
execute \
    as @s[scores={im_powersmash=10..19}] \
    run title @s title [{"text":""}]

execute \
    as @s[scores={im_powersmash=20}] \
    run playsound block.note_block.chime player @s ~ ~ ~ 1 0.595
execute \
    as @s[scores={im_powersmash=20..29}] \
    run title @s subtitle \
        [{"text":"\\u25cf ","underlined":true,"color":"green"},\
        {"text":"\\u25cf ","underlined":true,"color":"yellow"},\
        {"text":"\\u25cf ","underlined":true,"color":"dark_blue"},\
        {"text":"\\u2b24","underlined":true,"color":"dark_blue"}]

execute \
    as @s[scores={im_powersmash=30}] \
    run playsound block.note_block.chime player @s ~ ~ ~ 1 0.595
execute \
    as @s[scores={im_powersmash=30..39}] \
    run title @s subtitle \
        [{"text":"\\u25cf ","underlined":true,"color":"green"},\
        {"text":"\\u25cf ","underlined":true,"color":"yellow"},\
        {"text":"\\u25cf ","underlined":true,"color":"gold"},\
        {"text":"\\u2b24","underlined":true,"color":"dark_blue"}]

execute \
    as @s[scores={im_powersmash=40}] \
    run playsound block.note_block.chime player @s ~ ~ ~ 1 1.189
execute \
    as @s[scores={im_powersmash=40}] \
    run playsound block.note_block.bell player @s ~ ~ ~ 1 0.595
execute \
    as @s[scores={im_powersmash=40..49}] \
    run title @s subtitle \
        [{"text":"\\u25cf ","underlined":true,"color":"green"},\
        {"text":"\\u25cf ","underlined":true,"color":"yellow"},\
        {"text":"\\u25cf ","underlined":true,"color":"gold"},\
        {"text":"\\u272a","underlined":true,"color":"red"}]

execute \
    as @s[scores={im_powersmash=1..49}] \
    run title @s title [{"text":""}]