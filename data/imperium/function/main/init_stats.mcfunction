# Per-round combat stats for the post-game summary. Zeroed at round start (arena/start_round),
# read at round end (arena/end_round). Kills / dealt / taken accumulate automatically via their
# criteria — we only reset them per round. There is no vanilla "healed" criterion, so
# arena/track_healed samples health each tick and banks positive deltas into im_statHealed.
scoreboard objectives add im_matchKills playerKillCount
scoreboard objectives add im_statDealt custom:damage_dealt
scoreboard objectives add im_statTaken custom:damage_taken
scoreboard objectives add im_statHealed dummy

# Gold Rush score, derived from the stats above (arena/calc_gold): 1 per 25 damage dealt + 3 per kill,
# minus im_goldLost (cumulative gold forfeited to deaths). im_deaths (deathCount) drives the penalty.
scoreboard objectives add im_gold dummy
scoreboard objectives add im_goldLost dummy
scoreboard objectives add im_deaths deathCount

# "Seen" counters for the personal gold-gain chat feedback (announce only the delta since last check).
# im_goldDmgSeen = damage-derived gold already announced; im_killsSeen = kills already announced.
scoreboard objectives add im_goldDmgSeen dummy
scoreboard objectives add im_killsSeen dummy

# Kill-feed last-attacker tracking: each fighter gets a per-round im_combatId (handed out from the
# fake player #idCounter). On a hit, the victim records the attacker's id (im_lastAtkId) with a
# decaying credit window (im_lastAtkTime, seconds). on_death resolves the id back to the killer.
scoreboard objectives add im_combatId dummy
scoreboard objectives add im_lastAtkId dummy
scoreboard objectives add im_lastAtkTime dummy

# Last-seen health in tenths of HP (the healed-delta baseline) + a display scratch (whole/tenths
# split for end_round, and the per-tick delta for track_healed).
scoreboard objectives add im_hpSample dummy
