# BG hook (#summit.battlegrounds:api/player_died, runs as/at the victim).
# Gold Rush has NO elimination: infinite respawns for the round duration. The death
# penalty + kill feed fire separately via the im_deaths watcher (arena/on_death).
execute unless data storage summit.battlegrounds:database session{booth_id:"imperium"} run return 0
function imperium:arena/respawn
