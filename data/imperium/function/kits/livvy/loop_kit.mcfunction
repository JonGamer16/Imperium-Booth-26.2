# Per-Livvy per-tick logic — called `as @s at @s` from imperium:loop.

# Keep the Web charge count synced to her real remaining web potions (count-based stock).
#   Event-driven now: only re-count when she's actually thrown a lingering potion since last tick
#   (im_webUsedStat delta — a cheap score check). The old per-tick `clear ...[custom_data~] 0`
#   recount encoded the potion's custom_data component every tick; the count only ever changes on a
#   throw (spend) or a refill (cd2_web sets it directly), so recounting between throws was wasted
#   serialization. The recount itself stays authoritative for the throw tick.
scoreboard players operation @s im.temp = @s im_webUsedStat
scoreboard players operation @s im.temp -= @s im_webUsedPrev
scoreboard players operation @s im_webUsedPrev = @s im_webUsedStat
execute if score @s im.temp matches 1.. store result score @s im_cdUsesB \
    run clear @s lingering_potion[custom_data~{imperium_kit:1b}] 0
