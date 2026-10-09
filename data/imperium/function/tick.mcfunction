# SOLE DRIVER of all four loops. Registered directly in #minecraft:tick, so it runs everywhere,
# every tick, with nothing generated and nothing to configure.
#
# HISTORY (matters, because the failure mode was silent): this file used to be
# imperium:battlegrounds_tick, reachable only through the Summit-generated
# #summit.booth:persistent_tick function tag. A missing function tag inside #minecraft:tick logs
# NOTHING, so off the Summit server the entire pack was inert with a clean console. That is why the
# pack is registered in vanilla's own tick tag now — see data/minecraft/tags/function/tick.json.
#
# The two teleport pads are advancement-driven (imperium:booth/warp_from_{kitroom,shulkerbox}) and
# must stay that way — do not move them back in here, or they'd fire twice.
#
# DO NOT add a second driver. loop_tick is one monolithic pass over global @a/@e selectors, so two
# live drivers means every timed mechanic in the pack runs at double speed. That was the exact bug
# behind the old ticking_functions/persistent_tick split, and behind the shim's complement gate.
# There is now one driver, unconditionally, and no complement to keep in sync.

# Idle gate — skip the whole pass when there is provably nothing to do. Three populations, because
# neither implies the other:
#   im.kitted             somebody is holding a kit, so abilities/cooldowns need ticking. This is
#                         the same tag imperium:ability_zone gates on, so the gate can never be
#                         narrower than the abilities it drives.
#   imperium:safe_zone     somebody is inside the booth boxes, for the training dummy tether and
#                         upkeep in loop_5t/loop_1s, which run for players carrying no kit.
#   im.in_safe_zone           somebody was inside the boxes as of last tick. This clause exists purely
#                         so the FALLING edge below still gets a tick to fire after the last person
#                         walks out — without it the gate would close on the same tick they left,
#                         exit_booth would never run, and they would keep im.in_safe_zone forever.
# Kit-stand clicks are advancement-driven and do NOT depend on this function, so a player walking
# up to the stands with an empty inventory still gets served while this sits idle.
execute \
    unless entity @a[tag=im.kitted] \
    unless entity @a[predicate=imperium:safe_zone] \
    unless entity @a[tag=im.in_safe_zone] \
    run return 0

# Booth entry/exit edges. Replaces booth_definition on_player_enter / on_player_exit, which were
# delivered by the Summit booth runtime and do not exist standalone.
#
# im.in_safe_zone is the "was inside last tick" latch; comparing it against the live location predicate
# is what turns a continuous state into the two one-shot events the hooks expect. Each hook owns its
# own side of the latch (enter_booth adds it, exit_booth removes it) so neither can fire twice.
#
# `predicate=` as a selector argument evaluates at each matched player's own position, which is what
# makes this correct without an `at @s` — a bare `if predicate` would test this function's execution
# position instead and so match either everybody or nobody.
execute as @a[tag=!im.in_safe_zone,predicate=imperium:safe_zone] at @s run function imperium:booth/enter_booth
execute as @a[tag=im.in_safe_zone,predicate=!imperium:safe_zone] at @s run function imperium:booth/exit_booth

scoreboard players add #5t im.temp 1
scoreboard players add #1s im.temp 1

function imperium:loop_tick
function imperium:loop_enchantments
execute if score #5t im.temp matches 5 run function imperium:loop_5t
execute if score #1s im.temp matches 20 run function imperium:loop_1s

execute if score #5t im.temp matches 5 run scoreboard players set #5t im.temp 0
execute if score #1s im.temp matches 20 run scoreboard players set #1s im.temp 0
