tellraw @a [{"color":"#FFCC00","text":"[Imperium] "},{"color":"#00ff00","text":"Successfully Loaded!"}]

scoreboard objectives add givekit trigger
scoreboard objectives add onKill dummy
scoreboard objectives add summonerID dummy
# Shared scratch objective (set_cd macro, lifesteal_soup, etc.) — needed before the setup calls
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
# Rastus
    # Parry: per-player countdown for the full-deflect bubble (Strike & Parry share the
    # charge stored in im_melee_drought). -1 = inactive.
    scoreboard objectives add im_parryWindow dummy
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
    # Centralized ability tuning constants (see main/ability_parameters)
    scoreboard objectives add im.param dummy

# Grouped setup (see data/imperium/function/main/). Order matters:
#   constants must exist before init_cooldowns (the ability_cooldowns set_cd calls read them);
#   the setdisplay lines below need HP (game_triggers) and totalKills (old_objectives).

# Gamerules can't be changed in the summit
#   function imperium:main/gamerules

function imperium:main/enchantments
function imperium:main/game_triggers
function imperium:main/constants
function imperium:main/init_cooldowns
function imperium:main/init_stats
function imperium:main/old_objectives

# Ability tuning constants (durations, intervals, thresholds). After old_objectives so every
# mechanic objective it writes to (im_lifesteal, im.param, …) already exists.
function imperium:main/ability_parameters

# HUD displays
    # No global scoreboard displays allowed
    # scoreboard objectives setdisplay below_name im.hp
    # scoreboard objectives setdisplay list totalKills

# Testing (kept inline for quick reference)
team add w
scoreboard objectives add m_x dummy
scoreboard objectives add m_y dummy
scoreboard objectives add m_z dummy
scoreboard objectives add im_hp dummy
scoreboard objectives add im_maxhp dummy
scoreboard objectives add im_missinghp dummy
scoreboard objectives add im_raycast dummy
scoreboard objectives add im_hurt_time dummy
scoreboard objectives add carrot_on_a_stick dummy
scoreboard objectives add loops dummy
scoreboard objectives add im_lastKit dummy
scoreboard objectives add im_melee_drought dummy
#scoreboard objectives add carrot_on_a_stick minecraft.used:carrot_on_a_stick

# Reset Temporary Player Data
# data modify storage imperium:player_data players set value []
