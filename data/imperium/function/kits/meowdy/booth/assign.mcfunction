# Battlegrounds kit assignment (v2). Safe anywhere: the storage guard no-ops it off the
# Summit server, and the API itself rejects it unless imperium's session is active.
execute if data storage summit.battlegrounds:database session run function summit.battlegrounds:api/assign_kit/v2 {booth_id:"imperium", kit_id:"imperium:meowdy", kit_function:"imperium:kits/meowdy/givekit", kit_name:"Quin Meowdy"}
