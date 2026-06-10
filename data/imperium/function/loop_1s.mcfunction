#### 1-SECOND LOOP ####

# Straight Flight: despawn no-gravity arrows that have exceeded flight time
scoreboard players add @e[type=arrow,tag=im.straight_flight] im_arrowAge 1
kill @e[type=arrow,tag=im.straight_flight,scores={im_arrowAge=10..}]
