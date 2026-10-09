# Enter the fight. Called as the player from imperium:booth/exit_booth — i.e. on the FALLING edge of
# imperium:safe_zone, the moment they step off the spawn island. Continuous free-for-all: there is no
# round to join and no session to belong to, so this is the whole of "becoming a fighter".
#
# REPLACES arena/start_round + the #summit.battlegrounds:api/player_enter hook, both parked in
# zz_archive. What is deliberately NOT here, versus that round-based version:
#   im_lives            no elimination in a continuous FFA — you die, you respawn, you keep playing.
#   im_matchKills/      NOT zeroed. These feed arena/calc_gold, and gold is meant to accumulate
#   im_stat* / im_gold* across lives and sessions rather than reset per round. Leaving them alone is
#                       the first half of persistent gold; the rest (a real bank, spending, unlocks)
#                       is its own phase and will rework calc_gold properly.
#   im.round            round bookkeeping for the end-of-round leaderboard. No rounds, no leaderboard.

# Already fighting (re-entered the same tick, or the latch got out of step) — nothing to do.
execute if entity @s[tag=im.fighting] run return 0

# No kit, no fight. Stepping off the island empty-handed just means falling; abilities and scoring
# both key off holding a kit (imperium:ability_zone -> im.kitted), so tagging them would be a lie.
execute unless entity @s[tag=im.kitted] run return 0

tag @s add im.fighting

# Fresh combat id for kill-feed attacker resolution, and clear any stale last-attacker record.
# internal/record_attacker stamps the attacker's id on the victim; arena/kill_feed resolves it back
# to a player. The id must be unique per fighter, hence the shared #idCounter.
scoreboard players add #idCounter im_combatId 1
scoreboard players operation @s im_combatId = #idCounter im_combatId
scoreboard players set @s im_lastAtkId 0
scoreboard players set @s im_lastAtkTime 0

# Clear pre-applied effects so nothing carries off the island into the fight.
effect clear @s
