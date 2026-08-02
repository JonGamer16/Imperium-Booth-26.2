# Booth entity containment + ownership claiming. Runs every tick from imperium:loop_tick, so it
# fires wherever abilities tick (booth ticking_functions and the battlegrounds match loop). Two jobs:
#
#   1) Claim vanilla-spawned kit projectiles as booth-owned. Every entity WE make must carry
#      summit.booth_entity.imperium (Summit rule: it's how the server targets our entities and how
#      we avoid touching other booths' same-type entities). Function-summoned ability entities get
#      the tag at their summon (dart, crystal bomb, web, aim tracker) or when claimed near our caster
#      (grapple / mgrapple bobbers). Bow & crossbow arrows are spawned by vanilla, not by us, so we
#      claim them here the moment they exist.
#   2) Cull escapees: kill any owned MOBILE ability entity that has left the allowed area
#      (booth + arena + corridor clip — see imperium:in_bounds). Kill, per design.
#
# ORDER matters: claim first, then cull, so a just-claimed arrow is bounds-checked the same tick.

# --- 1. Claim kit arrows (bow + crossbow) + thrown potions ---
# Kit arrows carry the kit's imperium_kit custom_data, a key no other booth uses, so matching it is
# inherently ours-only — we never claim (and therefore never cull) a foreign booth's arrow.
# Fail-open: if a build ever stopped carrying the data onto the fired entity, arrows simply go
# unclaimed (uncontained) rather than anything foreign being culled.
#
# WHY THE SELECTOR IS ORDERED THIS WAY — type, then tag, then predicate, then nbt (optimization_guide
# 2.1.3; arguments are evaluated in written order):
#   tag=!summit.booth_entity.imperium  drops everything we have ALREADY claimed.
#   predicate=imperium:in_bounds       drops everything outside our region. This is the important one
#                                      on a live server: ~70 other booths are firing projectiles of
#                                      these same vanilla types, and every one of them sits in its own
#                                      region, so this rejects them for the price of a location check.
#   nbt={...}                          the expensive component read, now reached only by projectiles
#                                      that are unclaimed AND in our own region — in practice only
#                                      our own, on their first tick.
# Bounds-first is what keeps this ours-only in BOTH senses: we never read a foreign entity's NBT and
# we never write a tag to one. (Do not "optimize" this with a persistent `im.checked` marker stamped
# on everything we look at — that writes our tag onto other booths' entities, which the Summit rules
# forbid. It's the same reason kits/smokey/grapple_track dropped its old im.grapple_seen marker in
# favour of a proximity gate.)
#
# `predicate=` as a selector arg evaluates at each matched entity's own position, same as the culls
# in section 2 below. Claim-in-bounds is safe because a projectile is always still within a few
# blocks of the player who launched it on its first ticked frame, and that player is in bounds.
tag @e[type=arrow,tag=!summit.booth_entity.imperium,predicate=imperium:in_bounds,nbt={item:{components:{"minecraft:custom_data":{imperium_kit:1b}}}}] add summit.booth_entity.imperium

# Kit thrown potions (Livvy splash, Smokey lingering) carry imperium_kit, so claim them the same
# ours-only way, with the same argument ordering. GOTCHA: thrown item projectiles store their stack
# under capital `Item` (they're ThrownItemProjectiles), NOT the lowercase `item` the arrow uses above
# (arrows are a different entity class) — matching the wrong case silently claims nothing. NOTE: the
# 26.2 potion entity split means splash and lingering are separate types (formerly one `potion`).
# We do NOT claim the area_effect_cloud a lingering potion leaves — the cloud carries only
# potion_contents, not our custom_data, and it stays put + expires on its own, so only the fast
# thrown projectile can escape. (That cloud is matched, bounds-first, in imperium:loop_tick for the
# web and kits/smokey/loop_kit for the smoke bomb.)
tag @e[type=splash_potion,tag=!summit.booth_entity.imperium,predicate=imperium:in_bounds,nbt={Item:{components:{"minecraft:custom_data":{imperium_kit:1b}}}}] add summit.booth_entity.imperium
tag @e[type=lingering_potion,tag=!summit.booth_entity.imperium,predicate=imperium:in_bounds,nbt={Item:{components:{"minecraft:custom_data":{imperium_kit:1b}}}}] add summit.booth_entity.imperium

# Rastus's heal is a real THROWN splash potion (loot_table imperium:rastus/healing), and it carries
# imperium_healing, not imperium_kit — so the kit claim above never matched it. That left it as one of
# our own mobile entities flying around with no summit.booth_entity.imperium (Summit wants every
# entity of ours tagged) and outside the section-2 cull, and it also meant it failed the kit test on
# every tick of its flight instead of being claimed once. Claiming it fixes all three: it is tagged,
# it is contained, and it stops being re-read. Heals are the only other throwable we hand out — every
# remaining healing item (stew, chorus fruit, salmon, soup, end crystal) is consumed, not thrown.
tag @e[type=splash_potion,tag=!summit.booth_entity.imperium,predicate=imperium:in_bounds,nbt={Item:{components:{"minecraft:custom_data":{imperium_healing:1b}}}}] add summit.booth_entity.imperium

# --- 2. Cull escapees ---
# Only entities we own, and only the ones that travel on their own: arrows (dart + kit arrows),
# grapple bobbers, and thrown kit potions (splash + lingering). Placed entities (webs, crystal
# bombs) are created at an in-bounds player/impact and never move, so they can't drift out — no need
# to sweep them. in_bounds is a location_check, so it must be evaluated at the entity's position: the
# selector's `predicate=` arg does exactly that (it runs once per matched entity, at that entity's
# location), unlike `if predicate` which would read the loop's execution position instead.
kill @e[type=arrow,tag=summit.booth_entity.imperium,predicate=!imperium:in_bounds]
kill @e[type=fishing_bobber,tag=summit.booth_entity.imperium,predicate=!imperium:in_bounds]
kill @e[type=splash_potion,tag=summit.booth_entity.imperium,predicate=!imperium:in_bounds]
kill @e[type=lingering_potion,tag=summit.booth_entity.imperium,predicate=!imperium:in_bounds]
