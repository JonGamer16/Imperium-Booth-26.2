# Life Steal tick effect: runs every tick the enchanted weapon is held in mainhand.
# Just flag the holder; the loop reads this tick's damage delta and banks it.
scoreboard players set @s im_lsFlag 1
