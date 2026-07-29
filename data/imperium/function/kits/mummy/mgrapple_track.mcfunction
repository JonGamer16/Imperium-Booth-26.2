# Mummy Grappling Rod — per-tick tracker (called from imperium:loop, gated on a Mummy online).
#
# "Get over here": link each freshly-cast bobber to its caster (shared im_grappleId) -> each tick,
# while the bobber is hooked into an entity, tag that entity and arm the Mummy -> on reel-in (the
# bobber vanishes while the Mummy is armed), YANK the hooked entity to the Mummy. This is the
# reverse of Smokey, who pulls himself to the bobber. Mirrors the Smokey tracker with its own tags
# and its own #MummyGrapple* force params; only the #next id counter is shared (ids stay unique).
#
# Known edge (documented, accepted): if a grapple Smokey stands within 5 blocks of a Mummy as she
# casts, Smokey's tracker may also bind that bobber — same class of edge as the Smokey notes.

# 1. Who is holding the grappling rod (offhand fishing rod with the kit's custom_data).
tag @a[tag=im.mgrapple_user] remove im.mgrapple_user
execute as @a[tag=im.kit_mummy] \
    if items entity @s weapon.offhand fishing_rod[custom_data~{imperium_kit:1b}] \
    run tag @s add im.mgrapple_user

# 2. Claim any freshly-cast bobber that spawned on one of OUR rod holders (+ boost its cast speed).
#    The @p[tag=im.mgrapple_user,distance=..5] gate makes this ours-only: a foreign booth's bobber is
#    never beside one of our rod holders, so mgrapple_link never runs on it and no tag of ours is
#    written to it. mgrapple_link stamps im.mgrapple_bobber, so tag=!im.mgrapple_bobber is the
#    once-only guard — it replaces the old im.mgrapple_seen marker, which got stamped onto every
#    bobber in the world (foreign ones too).
execute as @e[type=fishing_bobber,tag=!im.mgrapple_bobber] at @s if entity @p[tag=im.mgrapple_user,distance=..5] run function imperium:kits/mummy/mgrapple_link

# 3. Per linked bobber: refresh the owner's "bobber live" flag + hooked target.
tag @a[tag=im.mgrapple_live] remove im.mgrapple_live
execute as @e[type=fishing_bobber,tag=im.mgrapple_bobber] at @s run function imperium:kits/mummy/mgrapple_scan

# 4. Bobber gone while armed (something was hooked): a real reel keeps the rod in the offhand (still
#    im.mgrapple_user) and yanks; a slot-change cancel drops the rod and just disarms. Clear armed
#    either way so a stale flag can't fire on the next cast.
execute as @a[tag=im.mgrapple_armed,tag=!im.mgrapple_live,tag=im.mgrapple_user] at @s run function imperium:kits/mummy/mgrapple_launch
# 4b. Same reel, but it spent the rod's last durability point: the rod is gone from the offhand by
#     the time we run, so the line above reads it as a cancel and the final yank is lost.
#     im.rod_broke (imperium:internal/rod_broke, advancement-driven) is set only by a durability
#     break, never by a slot swap, so it separates the two cleanly. tag=!im.mgrapple_user keeps this
#     mutually exclusive with the line above. Mirrors kits/smokey/grapple_track step 4b.
execute as @a[tag=im.mgrapple_armed,tag=!im.mgrapple_live,tag=!im.mgrapple_user,tag=im.rod_broke] at @s run function imperium:kits/mummy/mgrapple_launch
tag @a[tag=im.mgrapple_armed,tag=!im.mgrapple_live] remove im.mgrapple_armed
