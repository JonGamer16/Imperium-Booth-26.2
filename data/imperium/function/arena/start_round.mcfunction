# Begin a combat round for @s: clear the post-game stats and start tracking.
# Local test entry point — adds im.fighting, the local stand-in for summit.battlegrounds.player.
# The Summit player_enter hook should call this reset, then rely on the real BG tag for the gate.
scoreboard players set @s im_matchKills 0
scoreboard players set @s im_statDealt 0
scoreboard players set @s im_statTaken 0
scoreboard players set @s im_statHealed 0
scoreboard players set @s im_goldLost 0
scoreboard players set @s im_deaths 0
scoreboard players set @s im_goldDmgSeen 0
scoreboard players set @s im_killsSeen 0

# Fresh per-round combat id (for kill-feed attacker resolution) + clear any last-attacker record.
scoreboard players add #idCounter im_combatId 1
scoreboard players operation @s im_combatId = #idCounter im_combatId
scoreboard players set @s im_lastAtkId 0
scoreboard players set @s im_lastAtkTime 0

# Seed the health sample so the first healed-delta isn't measured from 0.
execute store result score @s im_hpSample run data get entity @s Health 10

tag @s add im.fighting
