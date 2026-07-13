# Register with the Baobab Battlegrounds (runs on load from imperium:main). In the local
# test world this logs one "unknown function" error and does nothing — expected; the API
# only exists on the Summit server.
# Default kit = Cliffshield (players who enter without ever selecting at the armor room).
# TODO(CONFIRM w/ staff): return_pos/return_rot are PLACEHOLDERS — set to the spot players
# should be dropped at after a session (outside the arena, facing it).
function summit.battlegrounds:api/register_booth {booth_id:"imperium", booth_name:"Imperium Mundi", return_pos:"[0.0d, 100.0d, 0.0d]", return_rot:"[0.0f, 0.0f]", struct_function:"imperium:summit/set_structure", compatibility:"imperium", kit_function:"imperium:kits/cliffshield/givekit"}
