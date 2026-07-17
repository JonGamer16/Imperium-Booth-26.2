# Spawn (or respawn) the Gold Rush standings billboard at the command position. Run this where you
# want the board to float over the arena, e.g. `execute positioned <x> <y> <z> run function
# imperium:arena/board_spawn`, or just stand where you want it. A single anchor marker
# (im.gold_board) holds a text_display (im.gold_board_text); arena/board_update rewrites the text
# each second from loop_1s. billboard:center keeps it facing spectators from any angle.
#
# VERSION-SENSITIVE: the `text` NBT is written in component form (1.21.5+). On older syntax it would
# need to be a quoted JSON string instead. Verify in-game and adjust if the board is invisible.
kill @e[type=text_display,tag=im.gold_board]
kill @e[type=text_display,tag=im.gold_board_text]

summon marker ~ ~ ~ {Tags:["im.gold_board"]}
summon text_display ~ ~2.4 ~ {Tags:["im.gold_board_text"],billboard:"center",alignment:"center",line_width:220,default_background:true,text:{text:"Gold Rush",color:"gold",bold:true},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]}}
