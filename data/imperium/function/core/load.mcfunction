# Core load: creates ONLY what the core pack's own files use (motion library + the self-contained
# enchantments). Idempotent, and sets no gamerules or other world-wide state (see SPLIT_PLAN.md).
# Registered in #minecraft:load AND called first by imperium:main, so kit PvP never reads a core
# objective before it exists, whatever order the packs load in.

# Shared scratch objective (volley, set_cd macro, lifesteal_soup, etc.). Distinct fake-player names
# give as many independent scratch slots as needed on this one objective.
scoreboard objectives add im.temp dummy

# Player launch module (imperium:motion/*). $x/$y/$z/$strength are the inputs, # names are scratch
# and per-bit flags. #max/#min are the 18-bit range the motion_impulse enchantment can encode.
scoreboard objectives add im.motion dummy
scoreboard players set #max im.motion 131071
scoreboard players set #min im.motion -131072
scoreboard players set #1000 im.motion 1000
scoreboard players set #-1 im.motion -1

# Backstab (arming is a `rotated as <target>` behind-zone check, no NBT)
scoreboard objectives add im_backstabflag dummy
scoreboard objectives add im_backstabtracking dummy
# High Jump: active flag + equip heartbeat (watchdog in core/tick)
scoreboard objectives add im_high_jump dummy
scoreboard objectives add im_high_jump_eq dummy
# Straight Flight: arrow age in seconds (core/second)
scoreboard objectives add im_arrowAge dummy

function imperium:main/constants
