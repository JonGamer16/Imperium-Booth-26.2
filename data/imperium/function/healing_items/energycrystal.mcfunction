# Mummy's Healing Item

clear @a[scores={rEnergyCrystal=1,onKill=1..}] end_crystal
give @a[scores={rEnergyCrystal=1,onKill=1..}] \
    end_crystal[\
        !can_place_on,\
        max_stack_size=1,\
        food={nutrition:0,saturation:0,can_always_eat:true},\
        consumable={\
            consume_seconds:0,\
            on_consume_effects:[\
                {type:"apply_effects",effects:[\
                    {id:"instant_health",amplifier:1,duration:1}]},\
                {type:"play_sound",sound:"block.beacon.activate"}\
            ]}\
    ] 10