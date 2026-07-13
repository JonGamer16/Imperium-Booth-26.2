# BG hook (#summit.battlegrounds:api/booth_inactive) — our session just ended.
execute unless data storage summit.battlegrounds:database session{booth_id:"imperium"} run return 0

# Rank the fighters and announce the interval champion (most gold), then close out and
# strip every fighter still tracked.
function imperium:arena/resolve_match
execute as @a[tag=im.fighting] run function imperium:summit/end_fighter
