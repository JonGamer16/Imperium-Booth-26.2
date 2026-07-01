# Runs each tick as an active web (cobweb block display), at its position. Hold every mob or player
# standing in the 1-block web (Livvy is immune; the web display, armor stands, items, projectiles
# etc. pass through — see #imperium:web_passthrough): refresh their hold heartbeat so it survives
# the loop's watchdog, and clamp any first-time victim via web_grab.
#   >> TUNING KNOB: the ..1 radius is the web's catch range (a ~1-block sphere from its center). <<
scoreboard players set @e[distance=..1,tag=!im.kit_livvy,type=!#imperium:web_passthrough] im_webbed 2
execute as @e[distance=..1,tag=!im.kit_livvy,tag=!im.webbed,type=!#imperium:web_passthrough] run function imperium:kits/livvy/web_grab
