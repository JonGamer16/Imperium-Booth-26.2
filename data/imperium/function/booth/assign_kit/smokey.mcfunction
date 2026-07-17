execute as @p run \
    function summit.battlegrounds:api/assign_kit/v2 \
    {\
        booth_id:"imperium", \
        kit_id: "imperium:smokey", \
        kit_function:"imperium:kits/smokey/givekit", \
        kit_name:"Smokey Bat"\
    } 