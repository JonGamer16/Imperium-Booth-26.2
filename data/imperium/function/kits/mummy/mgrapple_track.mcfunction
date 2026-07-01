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
tag @a remove im.mgrapple_user
execute as @a[tag=im.kit_mummy] \
    if items entity @s weapon.offhand fishing_rod[custom_data~{imperium_kit:1b}] \
    run tag @s add im.mgrapple_user

# 2. Link any freshly-cast bobber to its caster (+ boost its cast speed), then mark it seen so it's
#    only linked once. Uses a Mummy-specific seen tag so Smokey's tracker stays independent.
execute as @e[type=fishing_bobber,tag=!im.mgrapple_seen] at @s run function imperium:kits/mummy/mgrapple_link
tag @e[type=fishing_bobber,tag=!im.mgrapple_seen] add im.mgrapple_seen

# 3. Per linked bobber: refresh the owner's "bobber live" flag + hooked target.
tag @a remove im.mgrapple_live
execute as @e[type=fishing_bobber,tag=im.mgrapple_bobber] at @s run function imperium:kits/mummy/mgrapple_scan

# 4. Bobber gone while armed (something was hooked): a real reel keeps the rod in the offhand (still
#    im.mgrapple_user) and yanks; a slot-change cancel drops the rod and just disarms. Clear armed
#    either way so a stale flag can't fire on the next cast.
execute as @a[tag=im.mgrapple_armed,tag=!im.mgrapple_live,tag=im.mgrapple_user] at @s run function imperium:kits/mummy/mgrapple_launch
tag @a[tag=im.mgrapple_armed,tag=!im.mgrapple_live] remove im.mgrapple_armed
