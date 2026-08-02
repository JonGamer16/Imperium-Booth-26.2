# Runs as a player hit by Livvy's Venom Spray (Poison III, used only as the delivery signal).
# Convert it to the tracked im.venom tag with a 3s (60t) timer, then strip the vanilla poison
# so the damage is dealt as no-impact imperium:venom instead of global vanilla magic.
# Re-hits re-run this and refresh the timer. The spray deals NO impact damage of its own — the
# old prototype's Instant Damage was dropped, so all of Venom's damage now comes from the ticks in
# venom_tick. Poison III itself is never felt: it's stripped below before its first 6-tick interval.
#   >> Keep the amplifier at 2 in loot_table/livvy/potion — imperium:has_venom gates on min 2. <<

# Livvy is immune to Venom, mirroring web_apply's `tag=!im.kit_livvy`. She throws the spray at
# melee range, so she lands in her own cloud nearly every time — and a splash scales DURATION with
# distance, never amplifier, so even a glancing self-hit still reads as Poison III to has_venom and
# would arm the FULL #VenomDuration. At 2.0/tick that self-dose is ~7.5 HP, the highest venom total
# of any kit (armor 15 / toughness 8 / no Protection) — over a third of her health bar.
# Still strip the poison first: skipping her outright would leave real vanilla Poison III ticking
# on her, which is worse than the bug being fixed. Clear, then bail before arming the tag/timer.
# NOTE: this keys on the KIT tag, so one Livvy can't venom another either — same as the web. If
# that ever needs to be self-only, venom has to carry an owner id like the grapples' im_grappleId.
execute if entity @s[tag=im.kit_livvy] run effect clear @s minecraft:poison
execute if entity @s[tag=im.kit_livvy] run return 0

tag @s add im.venom
scoreboard players operation @s im_venomTimer = #VenomDuration im.param
effect clear @s minecraft:poison
