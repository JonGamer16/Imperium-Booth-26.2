# Kit-equip rate limit — release. Scheduled 5t out by kits/*/booth/click.
#
# WHY A SCHEDULE AND NOT A LOOP: this used to be one line in imperium:loop_1s, and that made kit
# SELECTION depend on the booth tick loop running. It doesn't run in the one place it had to:
# standing at the kit stands with no battlegrounds session live, imperium:battlegrounds_tick returns
# at its gate and the booth has no other 1s driver (the pack's #minecraft:tick is empty, and
# summit.booth is generated server-side). So im.equip_cd was set by the player's FIRST stand click
# and never released — every kit they picked afterwards was refused with "Kit swap recharging...",
# leaving them stuck on their first pick and walking into the arena with the wrong kit.
#
# A schedule needs no loop, no booth runtime and no session, so it cannot fail the same way.
# `replace` keeps at most one dispatch pending; this is a broadcast to every tagged player, so a
# second click inside the window costs nothing (worst case it releases a co-pending player early,
# which only ever grants an equip that was about to be allowed anyway).
#
# 5t, not 1s: the window only has to (a) collapse the same-tick double fire from the double-wired
# stand — Summit's Interactions API and imperium:booth/select_* both land on kits/*/booth/click —
# and (b) throttle held-down spam through the im_givekit pipeline. A quarter second does both and
# is far shorter than any deliberate "actually, give me Rastus instead" re-click.
tag @a[tag=im.equip_cd] remove im.equip_cd
