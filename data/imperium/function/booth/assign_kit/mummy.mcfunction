execute as @p run \
    function summit.battlegrounds:api/assign_kit/v2 \
    {\
        booth_id:"imperium", \
        kit_id: "imperium:mummy", \
        kit_function:"imperium:kits/mummy/givekit", \
        kit_name:"Mummy"\
    } 