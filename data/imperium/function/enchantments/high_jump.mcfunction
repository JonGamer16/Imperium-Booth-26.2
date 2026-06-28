# High Jump: low-gravity while rising, normal gravity once you fall.
# Runs every tick the enchant is equipped (minecraft:tick effect, executes as the wearer).

# Equip heartbeat: the loop watchdog ticks this down and strips the modifier if it ever
#   stops refreshing (i.e. the armor was unequipped). Refresh BEFORE the early-return below.
scoreboard players set @s im_high_jump_eq 2

# Grounded or holding jump (NOT floating): switch low-gravity on. Score check first (cheap),
#   predicate second (the slow check), and return so we skip the off-check this tick.
execute \
    unless score @s im_high_jump matches 1 \
    unless predicate imperium:floating \
    run return run function imperium:enchantments/high_jump_on

# Airborne with jump released (floating): switch low-gravity back off.
execute \
    if score @s im_high_jump matches 1 \
    if predicate imperium:floating \
    run function imperium:enchantments/high_jump_off
