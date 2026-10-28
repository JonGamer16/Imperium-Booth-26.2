scoreboard players set #core1s im.temp 0

# Straight Flight: despawn no-gravity arrows after 10 s. Matched by the enchantment's own
# im.straight_flight tag, so it works without kit PvP's im.owned claim. Kit PvP's loop_1s skips
# these arrows so they aren't aged twice.
scoreboard players add @e[type=#minecraft:arrows,tag=im.straight_flight] im_arrowAge 1
kill @e[type=#minecraft:arrows,tag=im.straight_flight,scores={im_arrowAge=10..}]
