# Battlegrounds kit assignment (v2). Safe anywhere: the storage guard no-ops it off the
# Summit server, and the API itself rejects it unless imperium's session is active.
function summit.battlegrounds:api/assign_kit/v2 {\
    booth_id:"imperium", \
    kit_id:"imperium:livvy", \
    kit_function:"imperium:kits/livvy/givekit", \
    kit_name:"Livvy the Vampire Spider"}
