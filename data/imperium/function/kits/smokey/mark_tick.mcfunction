# Per-tick upkeep for Smokey's Mark (im.marked). Counts down each marked player's 10s
# timer and drops the tag at 0, then emits the red marker particle on a 5-tick clock.
execute as @a[tag=im.marked] run scoreboard players remove @s im_markTimer 1
execute as @a[tag=im.marked,scores={im_markTimer=..0}] run tag @s remove im.marked

# 5-tick clock: red smoke-like particle (dust), count 10, centered on each marked target.
scoreboard players add #markClock im_markTimer 1
execute if score #markClock im_markTimer matches 5.. as @a[tag=im.marked] at @s run particle minecraft:dust{color:[1.0,0.0,0.0],scale:1.0} ~ ~1 ~ 0.3 0.5 0.3 0 10 normal @a[tag=im.fighting]
execute if score #markClock im_markTimer matches 5.. run scoreboard players set #markClock im_markTimer 0
