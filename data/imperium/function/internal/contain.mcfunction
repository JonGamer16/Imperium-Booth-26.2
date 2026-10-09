# Kit projectile ownership. Runs every tick from imperium:loop_tick.
#
# ONE job now: claim vanilla-spawned kit projectiles as ours by stamping
# im.owned on them. Function-summoned ability entities (dart, crystal bomb, web,
# aim tracker) get the tag at their summon, and grapple bobbers are claimed near our caster; bow and
# crossbow arrows are spawned by vanilla rather than by us, so they can only be claimed here, on
# the first tick they exist.
#
# The claim is NOT bookkeeping — two live mechanics read the tag:
#   imperium:loop_1s              ages owned arrows and despawns them at 10s. This is what makes
#                                 Straight Flight's no-gravity arrows expire instead of hanging in
#                                 the air forever.
#   kits/smokey/grapple_scan      tests for an owned entity as a grapple anchor.
#
# WHAT USED TO BE HERE — a second job, culling any owned mobile entity that left imperium:in_bounds
# (booth + arena + corridor). That is gone deliberately. The ability gate is now "is holding a kit"
# (imperium:ability_zone -> im.kitted), not "is standing inside the build", so kits are meant to work
# anywhere in the world — and a bounds cull would have killed every arrow, bobber and thrown potion
# the moment it left the pagoda. The bounds test is off the CLAIM for the same reason: gating the
# claim on location meant an arrow fired outside the build was never claimed, never aged by loop_1s,
# and a Straight Flight shot would hang in the air permanently.
#
# The removed bounds test also carried a Summit-only performance rationale (~70 booths all firing
# the same vanilla projectile types, so a location check was the cheap way to reject other people's
# entities before reading their NBT). Standalone there are no foreign booths to reject, so the
# ordering below is just: cheap tag test first, expensive NBT read last.

# --- Claim kit arrows (bow + crossbow) + thrown potions ---
# Kit projectiles carry imperium_kit custom_data, so the NBT test is what identifies them as ours.
# `tag=!im.owned` comes first and drops everything already claimed, so the NBT
# read only ever runs on an unclaimed projectile — in practice once, on its first ticked frame.
# Selector arguments are evaluated in written order (optimization_guide 2.1.3); keep it that way.
#
# Fail-open: if a build ever stopped carrying imperium_kit onto the fired entity, arrows would simply
# go unclaimed (and unaged) rather than anything being destroyed.
tag @e[type=arrow,tag=!im.owned,nbt={item:{components:{"minecraft:custom_data":{imperium_kit:1b}}}}] add im.owned

# Kit thrown potions (Livvy splash, Smokey lingering). GOTCHA: thrown item projectiles store their
# stack under capital `Item` (they're ThrownItemProjectiles), NOT the lowercase `item` the arrow uses
# above — arrows are a different entity class, and matching the wrong case silently claims nothing.
# NOTE: the 26.2 potion entity split means splash and lingering are separate types (formerly one
# `potion`). We do NOT claim the area_effect_cloud a lingering potion leaves: the cloud carries only
# potion_contents, not our custom_data, and it stays put and expires on its own. That cloud is
# matched by name in imperium:loop_tick (web) and kits/smokey/loop_kit (smoke bomb).
tag @e[type=splash_potion,tag=!im.owned,nbt={Item:{components:{"minecraft:custom_data":{imperium_kit:1b}}}}] add im.owned
tag @e[type=lingering_potion,tag=!im.owned,nbt={Item:{components:{"minecraft:custom_data":{imperium_kit:1b}}}}] add im.owned

# Rastus's heal is a real THROWN splash potion (loot_table imperium:rastus/healing) and it carries
# imperium_healing, not imperium_kit — so the kit claim above never matches it. Without this line it
# stays unclaimed and gets its NBT re-read on every tick of its flight. Heals are the only other
# throwable we hand out; every remaining healing item (stew, chorus fruit, salmon, soup, end crystal)
# is consumed, not thrown.
tag @e[type=splash_potion,tag=!im.owned,nbt={Item:{components:{"minecraft:custom_data":{imperium_healing:1b}}}}] add im.owned
