# Livvy's Healing Item

clear @a[scores={rBeetSoup=1,onKill=1..}] beetroot_soup
clear @a[scores={rBeetSoup=1,onKill=1..}] bowl
give @a[scores={rBeetSoup=1,onKill=1..}] \
    beetroot_soup[\
        food={nutrition:0,saturation:0,can_always_eat:true},\
        consumable={\
            consume_seconds:0,\
            on_consume_effects:[{type:"apply_effects",effects:[\
                {id:"instant_health",amplifier:0,duration:1}]}]},\
        use_remainder={"id":"bowl",count:1}\
    ] 20