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

# Lives for the round. Each death spends one (arena/on_death); at 0 the fighter is eliminated.
scoreboard players set @s im_lives 3

# Fresh per-round combat id (for kill-feed attacker resolution) + clear any last-attacker record.
scoreboard players add #idCounter im_combatId 1
scoreboard players operation @s im_combatId = #idCounter im_combatId
scoreboard players set @s im_lastAtkId 0
scoreboard players set @s im_lastAtkTime 0

# im.fighting = actively in the fight (abilities + death watcher gate). im.round = took part in this
# round; it OUTLIVES elimination so the end-of-round leaderboard (arena/resolve_match) can still rank
# players who ran out of lives. Cleared together in arena/round_over.
tag @s add im.fighting
tag @s add im.round

# Arena regen policy: BG players already lose Resistance V automatically, but BSL leaves
# their hunger alone — summit.no_regen additionally holds food at 8 (sprint yes, natural
# regen no). effect clear per the handbook so pre-applied Resistance/Saturation don't
# linger into the fight. end_round removes the tag.
tag @s add summit.no_regen
effect clear @s

# NO set_structure here. start_round runs per ENTERING PLAYER, so building the arena from this
# function re-placed all 39x17x45 of it every time someone joined a session already in progress —
# resetting the map under the fighters already in it, and kicking anyone the reload embedded in a
# block through BG's player/teleport/random. The arena is built once per session by the registered
# struct_function instead; see imperium:summit/set_structure.