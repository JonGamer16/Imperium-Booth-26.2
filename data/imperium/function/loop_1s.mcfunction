#### 1-SECOND LOOP ####

# Straight Flight: despawn no-gravity arrows that have exceeded flight time
scoreboard players add @e[type=#minecraft:arrows] im_arrowAge 1
kill @e[type=#minecraft:arrows,scores={im_arrowAge=10..}]

# hunger proofing
effect give @a[scores={hunger=0..19}] saturation 1 0