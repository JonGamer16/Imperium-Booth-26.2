execute as @p run \
    function summit.battlegrounds:api/assign_kit/v2 \
    {\
        booth_id:"imperium", \
        kit_id: "imperium:meowdy", \
        kit_function:"imperium:kits/meowdy/givekit", \
        kit_name:"Quin Meowdy"\
    } 