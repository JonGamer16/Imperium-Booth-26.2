# Volley (post_attack), as the VICTIM of a Volley crossbow arrow that just landed a real hit.
#
# Multishot arrows reach a target in the same tick, so vanilla's hurt cooldown rejects every arrow
# after the first. This lets the rest of the volley register WITHOUT touching arrow damage:
#
#   A #minecraft:bypasses_cooldown hit restarts the cooldown and sets the victim's damage threshold
#   (lastHurt) to its own amount. A 0.0001 hit therefore drops the threshold to ~0, and the next
#   arrow — which updates after this one, in the same tick — lands its full vanilla damage, with its
#   own Power / Punch / on-hit enchantments, armor, and death message. Verified by
#   imperium:test/bypass_cooldown (case C).
#
#   imperium:volley_reset is also no_impact + no_knockback, so the reset itself adds no push: arrow 1
#   carries the normal hit knockback, later arrows only their Punch extra (vanilla gives a hit landing
#   inside a cooldown no base knockback).
#
# Only reset when another arrow of the volley is still flying nearby — the reset also opens the
# victim to everyone else's follow-up for the rest of the cooldown, so a lone shot must not do it.
# The arrow that triggered this is still alive here (vanilla discards it after its on-hit effects),
# so it counts itself: 2+ means at least one more is inbound.

execute store result score #volley im.temp if entity @e[type=#minecraft:arrows,tag=im.volley,distance=..6]
execute if score #volley im.temp matches 2.. run damage @s 0.0001 imperium:volley_reset
