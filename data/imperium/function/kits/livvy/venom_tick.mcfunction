# Per-tick upkeep for Livvy's Venom (im.venom). Counts down each target's timer and drops the
# tag at 0, then deals no-impact imperium:venom damage on the #VenomInterval clock.
# imperium:venom is in #no_impact (no flinch) and #bypasses_cooldown (ticks land through i-frames).
# >> TUNING: #VenomDuration / #VenomInterval live in main/ability_parameters. Damage-per-hit
#    stays a literal below (the /damage command can't read a score). 63/7 = 9 hits of 2.0. <<
#
# Venom is DELIBERATELY not in #minecraft:bypasses_armor, despite reading as magic damage. Piercing
# would leave Protection as the only mitigation, and the pack's Protection values are lopsided
# (Levent 12, Mummy 8, everyone else 0) — that spreads venom 1.92x across kits. Going through armor
# instead keeps the spread at 1.47x, because armor values are all bunched at 15-17. Per-hit was
# raised 1.0 -> 2.0 to buy back the damage piercing would have given; the multiplier is flat across
# every kit, so the 2x costs nothing in fairness. Small hits are punished hardest by the armor
# curve, so if this needs more damage later, raise the per-hit before shortening #VenomInterval.
execute as @a[tag=im.venom] run scoreboard players remove @s im_venomTimer 1
execute as @a[tag=im.venom,scores={im_venomTimer=..0}] run tag @s remove im.venom

scoreboard players add #venomClock im_venomTimer 1
# Deal the venom tick. Attribute it to the nearest Livvy (by @p) so a venom kill gives HER the kill
# credit + death message (imperium.venom). `at @s` makes @p resolve from the victim's position.
# (Lifesteal is NOT driven by venom itself — that comes from venom-amplified melee, see
# imperium:combat/venom_bite. Attribution does add venom to her damage_dealt stat, a negligible
# incidental trickle into the bank while she holds the Fang.)
execute if score #venomClock im_venomTimer >= #VenomInterval im.param if entity @a[tag=im.kit_livvy] as @a[tag=im.venom] at @s run damage @s 2.0 imperium:venom by @p[tag=im.kit_livvy]
# Fallback: venom outlives its caster (this loop is ungated), so with no Livvy online deal it
# unattributed rather than let the `by` selector match nothing and drop the damage entirely.
execute if score #venomClock im_venomTimer >= #VenomInterval im.param unless entity @a[tag=im.kit_livvy] as @a[tag=im.venom] run damage @s 2.0 imperium:venom
execute if score #venomClock im_venomTimer >= #VenomInterval im.param run scoreboard players set #venomClock im_venomTimer 0
