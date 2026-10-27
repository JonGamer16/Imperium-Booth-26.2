# Debug message toggle: set to 1 to activate load success feedback and other test messages gated by it
scoreboard objectives add im_debug_mode dummy
scoreboard players set #Debug im_debug_mode 1
execute if score #Debug im_debug_mode matches 1 \
    run function imperium:util/debug

##########

scoreboard objectives add im_givekit trigger
scoreboard objectives add im_summonerID dummy

# Shared scratch objective (set_cd macro, lifesteal_soup, etc.) — needed before the setup calls.
# Distinct fake-player names give as many independent scratch slots as needed on this one objective.
scoreboard objectives add im.temp dummy

# Smokey
    # Grappling Rod: #next id counter + per-entity link (bobber<->caster), and the per-player
    # stored launch offset (also scratch for bobber/owner positions; see kits/smokey/grapple_*).
    scoreboard objectives add im_grappleId dummy
    scoreboard objectives add im_grappleX dummy
    scoreboard objectives add im_grappleY dummy
    scoreboard objectives add im_grappleZ dummy
    # Mark: per-player 10s tag timer + the shared #markClock particle clock
    scoreboard objectives add im_markTimer dummy
    scoreboard objectives add im_offhandCd dummy
# Rastus
    # Parry: per-player countdown for the full-deflect bubble (Strike & Parry share the
    # charge stored in im_melee_drought). -1 = inactive.
    scoreboard objectives add im_parryWindow dummy
    # Melee Drought Counter: ticks up while you haven't attacked
    scoreboard objectives add im_melee_drought dummy
    # Combo tax: hits landed in the current window, and ticks since the window's first hit.
    scoreboard objectives add im_comboHits dummy
    scoreboard objectives add im_comboTimer dummy
# Levent
    # Charge Attack
    scoreboard objectives add im_leventCharge dummy
# Livvy
    # Web Throw: per-web display lifetime (on the entity) + per-victim hold heartbeat
    scoreboard objectives add im_webLife dummy
    scoreboard objectives add im_webbed dummy
    # Venom: per-player 3s DoT timer + the shared #venomClock damage clock
    scoreboard objectives add im_venomTimer dummy
# Mummy
    # Energy: 0..100 ability pool shown on the action bar; spent by Golem Throw / Energy Barrier /
    # Mace Smash and refilled by consuming an Energy Crystal (see kits/mummy/energy_*).
    scoreboard objectives add im_energy dummy
    # Golem Throw: wind-up timer since the last throw (im_golemCharge) + the armed flag the enchant
    # reads on hit (im_golemReady = 1 when charged AND can afford it). See kits/mummy/golem_*.
    scoreboard objectives add im_golemCharge dummy
    scoreboard objectives add im_golemReady dummy
    # Crystal Bomb: per-bomb-entity fuse countdown (on the summoned end crystal). See kits/mummy/bomb_*.
    scoreboard objectives add im_bombFuse dummy
    # Crystal Bomb owner pairing: a shared id stamped on both the bomb and its placer so the blast can
    # spare the owner (#next holds the global counter). See kits/mummy/crystal_bomb + bomb_hurt.
    scoreboard objectives add im_bombId dummy
# Training dummy (booth): per-tick HP baseline that drives the damage indicator (x10 for 0.1-HP
# precision), the no-hit "lull" counter that triggers the between-visitors heal, and the per-label
# text_display lifetime. See booth/dummy/dmg_*.
    scoreboard objectives add im_hpPrev dummy
    scoreboard objectives add im_dmgLull dummy
    scoreboard objectives add im_indLife dummy
# Crosshair tracker (Rastus Focus Attack + Levent Charge Attack): a shared id stamped on both the
# player and their personal interaction entity so each tracker follows exactly one crosshair
# (#next holds the global counter). See enchantments/aim_tick + aim_bind + aim_free.
    scoreboard objectives add im_aimId dummy
    # Centralized ability tuning constants (see main/ability_parameters)
    scoreboard objectives add im.param dummy
# Player launch module (imperium:motion/*). $x/$y/$z/$strength are the inputs, # names are scratch
# and per-bit flags. #max/#min are the 18-bit range the motion_impulse enchantment can encode.
    scoreboard objectives add im.motion dummy
    scoreboard players set #max im.motion 131071
    scoreboard players set #min im.motion -131072
    scoreboard players set #1000 im.motion 1000
    scoreboard players set #-1 im.motion -1

# Grouped setup (see data/imperium/function/main/). Order matters:
#   constants must exist before init_cooldowns (the ability_cooldowns set_cd calls read them).

function imperium:main/enchantments
function imperium:main/game_triggers
function imperium:main/constants
function imperium:main/init_cooldowns
function imperium:main/init_stats

# Ability tuning constants (durations, intervals, thresholds). Runs after the setup functions above
# so every mechanic objective it writes to (im_lifesteal, im.param, …) already exists.
function imperium:main/ability_parameters

# Initialize global score holders (id counters, loop timers, DoT/particle clocks). These otherwise
# lazy-init from absent on their first `add`; seeding them here makes the baseline explicit and
# robust to any read-before-first-add. All their objectives are declared by the lines/functions above.
scoreboard players set #next im_aimId 0
scoreboard players set #next im_grappleId 0
scoreboard players set #next im_bombId 0
scoreboard players set #idCounter im_combatId 0
scoreboard players set #markClock im_markTimer 0
scoreboard players set #venomClock im_venomTimer 0
scoreboard players set #t5 im_5tTimer 0
scoreboard players set #sec im_secTimer 0
# Booth-rotation flag read by summit/player_enter (set only for the span of summit/booth_active).
scoreboard players set #rotation im.temp 0

# Kit-equip rate limit: release it for everyone on load. Every click that SETS im.equip_cd now
# schedules its own release in the same breath (booth/equip_cd_clear), so the tag can no longer
# outlive its window — but a schedule does not survive a reload or a restart, and players carrying
# the tag from before that fix (when the release lived in loop_1s, a loop that never runs at the kit
# stands) would otherwise stay locked out of kit selection forever. Nobody is legitimately mid-equip
# on load, so this is safe to keep permanently.
tag @a[tag=im.equip_cd] remove im.equip_cd

# Re-arm stuck event triggers (see util/rearm_triggers). Players offline now get it on kit equip.
execute as @a run function imperium:util/rearm_triggers

# im.kitted backfill. This tag is the single "has a kit" marker read by imperium:ability_zone and by
# the idle gate in imperium:tick, and it was introduced after the seven im.kit_* tags. A player
# already wearing a kit across the update has im.kit_<name> but no im.kitted, which would leave them
# outside the ability gate — abilities silently dead — until they walked back to a stand and
# re-equipped. Deriving it from the kit tags on load costs seven tag tests once and self-heals that.
# Kits set im.kitted themselves from here on (see kits/*/givekit), so this only ever matters once.
tag @a[tag=im.kit_cliffshield] add im.kitted
tag @a[tag=im.kit_levent] add im.kitted
tag @a[tag=im.kit_livvy] add im.kitted
tag @a[tag=im.kit_meowdy] add im.kitted
tag @a[tag=im.kit_mummy] add im.kitted
tag @a[tag=im.kit_rastus] add im.kitted
tag @a[tag=im.kit_smokey] add im.kitted


# HUD displays
    # No global scoreboard displays allowed

# Testing (kept inline for quick reference)
    scoreboard objectives add im_loops dummy
    scoreboard objectives add im_lastKit dummy

