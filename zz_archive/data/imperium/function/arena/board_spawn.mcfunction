# Spawn (or respawn) the Gold Rush standings billboard over the arena. Called from
# imperium:summit/set_structure, i.e. once per session as our booth takes over the battlegrounds.
#
# ONE ENTITY PER LINE, stacked downward from -98 85 118. Coordinates are hardcoded rather than
# `~ ~ ~` because the caller is the struct_function, which does not run anywhere near the arena.
# Lines sit 1 block apart: a text_display line is ~0.25 blocks tall and these render at scale 4,
# so 1.0 stacks the four backgrounds flush into one board with no seam and no overlap. Confirmed
# in-game. If you retune, keep spacing == 0.25 * scale or the lines will gap or overlap.
#
# billboard:"vertical" — the board pivots to follow the viewer horizontally but stays upright,
# so it stays readable from anywhere around the arena without tipping for players above or below.
#
# summit.dynamic is REQUIRED here, not cosmetic. Entities default to summit.static on the Summit
# server, and static entities never send updates to the client — board_update would rewrite the
# text every second while spectators saw the values frozen at whatever they were on spawn.
# summit.booth_entity.imperium is mandatory on every entity we own.
#
# Idempotent: clears the whole board first, so a re-activation or a manual re-run can't stack a
# second set of lines on top of the first.
function imperium:arena/board_kill

# Title line — static text, written once here. board_update never touches it.
summon text_display -98 85 118 {\
    Tags:["im.gold_board","im.gold_board_l0","summit.booth_entity.imperium","summit.dynamic"],\
    billboard:"vertical",\
    alignment:"center",\
    line_width:250,\
    default_background:true,\
    transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[4f,4f,4f]},\
    text:[{text:"⚔ Imperium Mundi: Gold Rush ⚔",color:"gold",bold:true}]}

# Rank lines — placeholder text until the first board_update pass (within 1s, from loop_1s).
summon text_display -98 84 118 {\
    Tags:["im.gold_board","im.gold_board_l1","summit.booth_entity.imperium","summit.dynamic"],\
    billboard:"vertical",\
    alignment:"center",\
    line_width:250,\
    default_background:true,\
    transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[4f,4f,4f]},\
    text:[{text:"1st -",color:"yellow"}]}

summon text_display -98 83 118 {\
    Tags:["im.gold_board","im.gold_board_l2","summit.booth_entity.imperium","summit.dynamic"],\
    billboard:"vertical",\
    alignment:"center",\
    line_width:250,\
    default_background:true,\
    transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[4f,4f,4f]},\
    text:[{text:"2nd -",color:"gray"}]}

summon text_display -98 82 118 {\
    Tags:["im.gold_board","im.gold_board_l3","summit.booth_entity.imperium","summit.dynamic"],\
    billboard:"vertical",\
    alignment:"center",\
    line_width:250,\
    default_background:true,\
    transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[4f,4f,4f]},\
    text:[{text:"3rd -",color:"gold"}]}
