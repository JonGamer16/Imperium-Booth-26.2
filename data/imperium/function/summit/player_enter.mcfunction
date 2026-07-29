# BG hook (#summit.battlegrounds:api/player_enter, runs as/at the entering player).
# Only act while imperium's session is the active one.
execute unless data storage summit.battlegrounds:database session{booth_id:"imperium"} run return 0

# Cache + clear the outside inventory before the battlegrounds hands out the kit. This hook runs
# one step ahead of BG's give_kit -> `clear @s *`, so it's the last chance to save what the player
# walked in with (no-op if the booth already cached it at a kit stand).
# Skipped on a booth ROTATION (see summit/booth_active): those players are already mid-arena
# holding the previous booth's kit, and caching that would hand a foreign kit back on leave.
execute unless score #rotation im.temp matches 1 run function imperium:util/inv_cache

# Re-assert the player's saved kit choice (im_lastKit survives shard hops via
# sync_setting/kit.json) so this session uses it instead of the Cliffshield default.
function imperium:summit/assign_lastkit

# Gold Rush round tracking + the arena regen policy (summit.no_regen inside).
function imperium:arena/start_round
