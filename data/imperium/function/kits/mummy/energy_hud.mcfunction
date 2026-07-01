# Mummy Energy meter — action bar readout (runs per tick for each Mummy via energy_tick). The number
# is the live im_energy score so players watch it drop as abilities spend it and climb as crystals
# refill it. Color-code the number by how much is banked: green plenty / yellow low / red critical.
execute \
    if score @s im_energy matches 50.. \
    run title @s actionbar [\
        {"text":"⚡⚡⚡ ","color":"light_purple","bold":true},\
        {"score":{"name":"@s","objective":"im_energy"},"color":"light_purple","bold":true},\
        {"text":"% ⚡⚡⚡","color":"light_purple"}]
execute \
    if score @s im_energy matches 20..49 run title @s actionbar [\
        {"text":"⚡⚡ ","color":"dark_purple","bold":true},\
        {"score":{"name":"@s","objective":"im_energy"},"color":"dark_purple","bold":true},\
        {"text":"% ⚡⚡","color":"dark_purple"}]
execute \
    if score @s im_energy matches ..19 run title @s actionbar [\
        {"text":"⚡ ","color":"dark_gray","bold":true},\
        {"score":{"name":"@s","objective":"im_energy"},"color":"dark_gray","bold":true},\
        {"text":"% ⚡","color":"dark_gray"}]
