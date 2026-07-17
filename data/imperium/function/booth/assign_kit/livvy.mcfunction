execute as @p run \
    function summit.battlegrounds:api/assign_kit/v2 \
    {\
        booth_id:"imperium", \
        kit_id: "imperium:livvy", \
        kit_function:"imperium:kits/livvy/givekit", \
        kit_name:"Livvy"\
    } 