tellraw @a [{"color":"#FFCC00","text":"[Imperium] "},{"color":"#00ff00","text":"Successfully Loaded!"}]

scoreboard objectives add givekit trigger
scoreboard objectives add onKill dummy
scoreboard objectives add summonerID dummy
# Shared scratch objective (set_cd macro, lifesteal_soup, etc.) — needed before the setup calls
scoreboard objectives add im.temp dummy

# Grouped setup (see data/imperium/function/main/). Order matters:
#   constants must exist before ability_cooldowns (init_cooldowns macro reads them);
#   the setdisplay lines below need HP (game_triggers) and totalKills (old_objectives).
function imperium:main/gamerules
function imperium:main/enchantments
function imperium:main/game_triggers
function imperium:main/constants
function imperium:main/ability_cooldowns
function imperium:main/old_objectives

# HUD displays
scoreboard objectives setdisplay below_name HP
scoreboard objectives setdisplay list totalKills

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
