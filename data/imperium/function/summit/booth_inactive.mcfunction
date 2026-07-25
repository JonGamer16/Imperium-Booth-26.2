# BG hook (#summit.battlegrounds:api/booth_inactive) — our session just ended.
execute unless data storage summit.battlegrounds:database session{booth_id:"imperium"} run return 0

# Interval time-out (not a last-man-standing finish): rank purely by gold. #earlyEnd=0 so
# resolve_match crowns the most gold rather than a survivor. round_over posts the leaderboard,
# then closes out and strips every fighter still tracked.
scoreboard players set #earlyEnd im.temp 0
function imperium:arena/round_over
