# End the round: post the final leaderboard, then close out everyone still fighting and drop the
# round-participant tag. #earlyEnd im.temp is set by the caller — eliminate (1 = last-man-standing)
# or booth_inactive (0 = interval time-out) — and steers who resolve_match crowns first.
function imperium:arena/resolve_match
execute as @a[tag=im.fighting] run function imperium:summit/end_fighter
tag @a[tag=im.round] remove im.round
