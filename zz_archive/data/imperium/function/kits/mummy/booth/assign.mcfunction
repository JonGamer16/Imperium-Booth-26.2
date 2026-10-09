# Battlegrounds kit assignment (v2). Safe anywhere: the storage guard no-ops it off the
# Summit server, and the API itself rejects it unless imperium's session is active.
function summit.battlegrounds:api/assign_kit/v2 {\
    booth_id:"imperium", \
    kit_id:"imperium:mummy", \
    kit_function:"imperium:kits/mummy/givekit", \
    kit_name:"Warforged Mummy"}
