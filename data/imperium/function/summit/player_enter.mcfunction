# BG hook (#summit.battlegrounds:api/player_enter, runs as/at the entering player).
# Only act while imperium's session is the active one.
execute unless data storage summit.battlegrounds:database session{booth_id:"imperium"} run return 0

# Re-assert the player's saved kit choice (im_lastKit survives shard hops via
# sync_setting/kit.json) so this session uses it instead of the Cliffshield default.
function imperium:summit/assign_lastkit

# Gold Rush round tracking + the arena regen policy (summit.no_regen inside).
function imperium:arena/start_round
