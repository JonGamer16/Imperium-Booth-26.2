# Air Dodge stock readout (Rastus). Called from BOTH ends of the charge count so the actionbar
# always reflects the live number: air_dodge after spending one, cd3_dodge after banking one.
# Max comes off #Rastus rather than @s so the denominator still reads right on the tick a kit
# swap has zeroed the player copy.
title @s actionbar [\
    {"text":"⇢ Dash ","color":"aqua"},\
    {"score":{"name":"@s","objective":"im_cdUsesC"},"color":"white"},\
    {"text":" / ","color":"gray"},\
    {"score":{"name":"#Rastus","objective":"im_cdMaxC"},"color":"gray"}\
]
