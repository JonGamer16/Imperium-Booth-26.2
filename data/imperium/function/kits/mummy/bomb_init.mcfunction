# Initialize a freshly placed Crystal Bomb (runs as the end crystal). Start its fuse and mark it live
# so the loop's fuse tick picks it up. Runs the same tick it's summoned.
scoreboard players operation @s im_bombFuse = #BombFuse im.param
tag @s add im.bomb_live
