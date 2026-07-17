execute as @p run \
    function summit.battlegrounds:api/assign_kit/v2 \
    {\
        booth_id:"imperium", \
        kit_id: "imperium:levent", \
        kit_function:"imperium:kits/levent/givekit", \
        kit_name:"Levent"\
    } 