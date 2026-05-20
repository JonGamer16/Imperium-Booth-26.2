tellraw @a [{"color":"#FFCC00","text":"[Imperium] "},{"color":"#00ff00","text":"Successfully Loaded!"}]

scoreboard objectives add givekit trigger
scoreboard objectives add onKill dummy
scoreboard objectives add summonerID dummy

# World Gamerules
gamerule allow_entering_nether_using_portals false
gamerule block_drops false
gamerule ender_pearls_vanish_on_death true
gamerule entity_drops false
gamerule fire_spread_radius_around_player 0
gamerule immediate_respawn true
gamerule keep_inventory true
gamerule mob_drops false
gamerule mob_griefing false
gamerule natural_health_regeneration false
gamerule raids false
gamerule random_tick_speed 0
gamerule reduced_debug_info true
gamerule respawn_radius 0
gamerule spawn_mobs false
gamerule spawn_patrols false
gamerule spawn_phantoms false
gamerule spectators_generate_chunks false
gamerule spread_vines false
gamerule tnt_explodes false

# Damage Based Refill Items
scoreboard objectives add rArrow dummy
scoreboard objectives add rBlazePowder dummy
scoreboard objectives add rBoat dummy
scoreboard objectives add rGravityArrow dummy
scoreboard objectives add rHarmPot dummy
scoreboard objectives add rJumpPot dummy
scoreboard objectives add rPearl dummy
scoreboard objectives add rPoisonArrow dummy
scoreboard objectives add rShield dummy
scoreboard objectives add rSlowPot dummy
scoreboard objectives add rTotem dummy
scoreboard objectives add rTrident2 dummy
scoreboard objectives add rWindCharge dummy

# Kill Based Refill Items
scoreboard objectives add rGoldArmor dummy
scoreboard objectives add rTrident dummy

# Healing items
scoreboard objectives add rBeetSoup dummy
scoreboard objectives add rMushSoup dummy
scoreboard objectives add rRabbitSoup dummy
scoreboard objectives add rCraftSoup dummy

scoreboard objectives add rCake dummy
scoreboard objectives add rEnergyCrystal dummy
scoreboard objectives add rGapple dummy
scoreboard objectives add rHeal2Pot dummy
scoreboard objectives add rRegenPot dummy
scoreboard objectives add rSalmon dummy

# Summoning Items
scoreboard objectives add rBlazeEgg dummy
scoreboard objectives add rCamelEgg dummy
scoreboard objectives add rWolfEgg dummy
scoreboard objectives add rZombieEgg dummy

# Summoning Teams
team add blaze
team add zombie

# Enchantments
scoreboard objectives add tempDamage custom:damage_dealt

scoreboard objectives add im_brittleArmorDura dummy
scoreboard objectives add im_brittleDamage custom:damage_taken
scoreboard objectives add im_brittleDura dummy
scoreboard objectives add im_brittleFlag dummy
scoreboard objectives add im_brittleValidDamage dummy
scoreboard objectives add im_brittleHealthTemp dummy
scoreboard objectives add im_brittleHealthPrev dummy
scoreboard objectives add im_brittleNetDamage dummy
scoreboard objectives add im_brittleNetDamageAccum dummy

scoreboard objectives add im_rotation dummy
scoreboard objectives add im_rotationdiff dummy
scoreboard objectives add im_backstabflag dummy
scoreboard objectives add im_backstabraycast dummy
scoreboard objectives add im_backstabtracking dummy
scoreboard objectives add im_temperlevel dummy
scoreboard objectives add im_temperinitialdmg dummy
scoreboard objectives add im_temperinitialmodif dummy
scoreboard objectives add im_temperwhole dummy
scoreboard objectives add im_temperdecimal dummy
scoreboard objectives add im_tipper dummy
scoreboard objectives add im_tipperdistance dummy
scoreboard objectives add im_tipperraycast dummy
scoreboard objectives add im_powersmash dummy
scoreboard objectives add im.chinks_weapon dummy
scoreboard objectives add im.chinks_armor dummy
scoreboard objectives add im.dmg dummy
scoreboard objectives add im.max dummy
scoreboard objectives add im.chinks_weapon_prev dummy
scoreboard objectives add im.chinks_armor_prev dummy

# Item reloads
scoreboard objectives add itemreload custom:damage_dealt

# Game triggers
scoreboard objectives add killDamage custom:damage_dealt
scoreboard objectives add killFlag playerKillCount
scoreboard objectives add HP health
scoreboard objectives add hunger food
scoreboard objectives add onDeath deathCount
scoreboard objectives add onJoin custom:play_time
scoreboard objectives add onLeave custom:leave_game

# Player Progression
scoreboard objectives add highestDamageRecord dummy
scoreboard objectives add totalDamage custom:damage_dealt
scoreboard objectives add gold dummy
scoreboard objectives add silver dummy
scoreboard objectives add damageThisLife custom:damage_dealt
scoreboard objectives add totalKills playerKillCount
scoreboard objectives add totalDeaths deathCount

scoreboard objectives setdisplay below_name HP
scoreboard objectives setdisplay list totalKills

# Testing
team add w
scoreboard objectives add m_x dummy
scoreboard objectives add m_y dummy
scoreboard objectives add m_z dummy
scoreboard objectives add im.temp dummy
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

# Constants
scoreboard objectives add 0 dummy
scoreboard players set const 0 0
scoreboard objectives add 1 dummy
scoreboard players set const 1 1
scoreboard objectives add 2 dummy
scoreboard players set const 2 2
scoreboard objectives add 3 dummy
scoreboard players set const 3 3
scoreboard objectives add 4 dummy
scoreboard players set const 4 4
scoreboard objectives add 5 dummy
scoreboard players set const 5 5
scoreboard objectives add 10 dummy
scoreboard players set const 10 10
scoreboard objectives add 20 dummy
scoreboard players set const 20 20
scoreboard objectives add 100 dummy
scoreboard players set const 100 100
scoreboard objectives add 200 dummy
scoreboard players set const 200 200
scoreboard objectives add 500 dummy
scoreboard players set const 500 500
scoreboard objectives add 1000 dummy
scoreboard players set const 1000 1000
scoreboard objectives add 2000 dummy
scoreboard players set const 2000 2000
scoreboard objectives add 5000 dummy
scoreboard players set const 5000 5000
scoreboard objectives add 10000 dummy
scoreboard players set const 10000 10000

# Player DB
execute as @a run function pdb:new_player

# Reset Temporary Player Data
# data modify storage imperium:player_data players set value []
scoreboard objectives add im_reach dummy
scoreboard objectives add im_sweetspot dummy
scoreboard objectives add im_sourspot dummy
