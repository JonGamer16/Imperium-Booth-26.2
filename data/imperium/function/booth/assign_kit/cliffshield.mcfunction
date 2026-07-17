execute as @p run \
    function summit.battlegrounds:api/assign_kit/v2 \
    {\
        booth_id:"imperium", \
        kit_id: "imperium:cliffshield", \
        kit_function:"imperium:kits/cliffshield/givekit", \
        kit_name:"Jeru Cliffshield"\
    } 