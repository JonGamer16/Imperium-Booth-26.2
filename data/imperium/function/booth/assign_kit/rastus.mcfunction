execute as @p run \
    function summit.battlegrounds:api/assign_kit/v2 \
    {\
        booth_id:"imperium", \
        kit_id: "imperium:rastus", \
        kit_function:"imperium:kits/rastus/givekit", \
        kit_name:"Rastus"\
    } 