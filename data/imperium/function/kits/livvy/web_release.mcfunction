# Free of every web (runs as the victim) — strip the cobweb clamp. Mirror of web_grab. The loop's
# watchdog calls this the tick after im_webbed decays to 0 (no web refreshed it for 2 ticks).
tag @s remove im.webbed
attribute @s minecraft:movement_speed modifier remove imperium:web
attribute @s minecraft:air_drag_modifier modifier remove imperium:web
