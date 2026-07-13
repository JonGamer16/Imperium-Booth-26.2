# BG hook (#summit.battlegrounds:api/player_leave, runs as/at the leaving player).
execute unless data storage summit.battlegrounds:database session{booth_id:"imperium"} run return 0
function imperium:summit/end_fighter
