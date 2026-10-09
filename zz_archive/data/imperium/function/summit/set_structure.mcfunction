# Battlegrounds structure override — the struct_function registered in summit/register_booth.
# BG calls this from battleground/session/start every time our booth takes over the arena (both a
# fresh activation and a queue rotation into us), just before #summit.battlegrounds:api/booth_active.
# That is the ONLY place the arena should be built: it fires once per session, not once per entrant.
#
# `structure` is a resource location and MUST carry the namespace. Our file lives at
# data/imperium/structure/imperium_arena.nbt, so the id is imperium:imperium_arena — a bare
# "imperium_arena" resolves to minecraft:imperium_arena, which doesn't exist, and the structure
# block then loads nothing at all (silently: no command error, the block is placed and powered
# fine, it just has no structure to read). Compare summit's own default call, which passes the
# fully-qualified "summit.battlegrounds:default".
#
# The API self-guards on the session belonging to us and returns -1 otherwise, so this is safe to
# call unconditionally. Structure size is 39x17x45, matching the arena footprint the BG structure
# block expects.
function summit.battlegrounds:api/set_structure {booth_id:"imperium", structure:"imperium:imperium_arena"}

# Gold Rush standings billboard. Lives here rather than in the schematic or the structure file:
# the arena is outside the booth's bounding boxes (so the schematic never covers it) and BG's
# structure block loads with ignoreEntities:1b (so the .nbt can't carry it either) — a function is
# the only way arena entities can exist. Runs AFTER the structure lands, though the order is not
# actually load-bearing, since the structure placement ignores entities in both directions.
function imperium:arena/board_spawn
