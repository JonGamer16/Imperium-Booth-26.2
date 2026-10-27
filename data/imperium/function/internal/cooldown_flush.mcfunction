# Scheduled 1t after any dealt-damage hit (internal/cooldown_dealt). Runs server-side, so it
# re-selects everyone with a pending hit; one schedule covers all players hitting that tick.
execute as @a[tag=im.cd_dealt_pending] run function imperium:internal/cooldown_dealt_apply
