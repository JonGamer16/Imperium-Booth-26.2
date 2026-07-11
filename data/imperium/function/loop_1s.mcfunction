#### 1-SECOND LOOP ####

# Straight Flight: despawn no-gravity arrows that have exceeded flight time
scoreboard players add @e[type=#minecraft:arrows] im_arrowAge 1
kill @e[type=#minecraft:arrows,scores={im_arrowAge=10..}]


# gold rush: keep each fighter's im_gold current (for the live display / standings)
execute as @a[tag=im.fighting] run function imperium:arena/calc_gold
# gold rush: personal "[Kill Score] +3 Gold" chat for new kills
execute as @a[tag=im.fighting] run function imperium:arena/gold_kill_bonus
# gold rush: refresh the spectator standings billboard (self-guards if no board is spawned)
function imperium:arena/board_update
# gold rush: decay the kill-feed last-attacker credit window
scoreboard players remove @a[tag=im.fighting,scores={im_lastAtkTime=1..}] im_lastAtkTime 1