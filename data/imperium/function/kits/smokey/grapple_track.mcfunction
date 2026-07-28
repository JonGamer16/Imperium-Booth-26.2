# Smokey Grappling Rod — per-tick tracker (called from imperium:loop, gated on a Smokey online).
#
# Flow: link each freshly-cast bobber to its caster (shared im_grappleId) -> each tick, while the
# bobber is anchored (resting on ground OR a hookable entity sits on it), store the bobber->owner
# offset on the owner and arm them -> on reel-in (the bobber vanishes while the owner is armed),
# launch the owner toward that offset + a static vertical pop (kits/smokey/grapple_launch).
#
# Known edge cases (documented, accepted for now — see zz_todo Smokey/Grapple Rod):
#   - bobber auto-retract (>33 blocks / line-of-sight lost) counts as a reel and grapples
#   - reel-vs-cancel relies on the rod still being in the offhand; a cancel that keeps it there
#     wouldn't be caught (fishing_rod_hooked is unreliable for ground reels)
#   - an entity reel that breaks the rod (durability) removes it, so that launch is missed

# 1. Who is holding the grappling rod (offhand fishing rod with the kit's custom_data).
tag @a[tag=im.grapple_user] remove im.grapple_user
execute as @a[tag=im.kit_smokey] \
    if items entity @s weapon.offhand fishing_rod[custom_data~{imperium_kit:1b}] \
    run tag @s add im.grapple_user

# 2. Claim any freshly-cast bobber that spawned on one of OUR rod holders (bobbers spawn on the
#    caster), linking it to that caster via a shared id. The @p[tag=im.grapple_user,distance=..5]
#    gate is what makes this ours-only: a foreign booth's bobber is never beside one of our rod
#    holders, so grapple_link never runs on it and no tag of ours is ever written to it. grapple_link
#    stamps im.grapple_bobber, so tag=!im.grapple_bobber is the once-only guard — it replaces the old
#    im.grapple_seen marker, which used to get stamped onto every bobber in the world (foreign ones too).
execute as @e[type=fishing_bobber,tag=!im.grapple_bobber] at @s if entity @p[tag=im.grapple_user,distance=..5] run function imperium:kits/smokey/grapple_link

# 3. Per linked bobber: refresh its owner's "bobber still live" flag + anchored offset.
tag @a[tag=im.grapple_live] remove im.grapple_live
execute as @e[type=fishing_bobber,tag=im.grapple_bobber] at @s run function imperium:kits/smokey/grapple_scan

# 4. Bobber gone while armed: a real reel keeps the rod in the offhand (still im.grapple_user) and
#    launches; a slot-change cancel removes the rod from the hand (no longer im.grapple_user) and
#    just disarms. Clear armed either way so a stale flag can't fire on the next cast.
execute as @a[tag=im.grapple_armed,tag=!im.grapple_live,tag=im.grapple_user] at @s run function imperium:kits/smokey/grapple_launch
tag @a[tag=im.grapple_armed,tag=!im.grapple_live] remove im.grapple_armed
