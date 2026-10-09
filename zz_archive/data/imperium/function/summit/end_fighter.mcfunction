# Close out one fighter (@s): post-game stats + stop tracking (end_round also drops
# summit.no_regen), then take the kit away — Summit only auto-deletes items handed out
# inside the booth BOUNDS, not arena kit items, so we clear them ourselves.
function imperium:arena/end_round
function imperium:util/clear_kit
