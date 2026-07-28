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
# inherently ours-only — we never claim (and therefore never cull) a foreign booth's arrow. The
# tag=! gate means only not-yet-claimed arrows get NBT-tested, so this isn't a per-tick NBT scan of
# every arrow in the world. Fail-open: if a build ever stopped carrying the data onto the fired
# entity, arrows simply go unclaimed (uncontained) rather than anything foreign being culled.
tag @e[type=arrow,tag=!summit.booth_entity.imperium,nbt={item:{components:{"minecraft:custom_data":{imperium_kit:1b}}}}] add summit.booth_entity.imperium

# Kit thrown potions (Livvy splash, Smokey lingering) carry imperium_kit, so claim them the same
# ours-only way. GOTCHA: thrown item projectiles store their stack under capital `Item` (they're
# ThrownItemProjectiles), NOT the lowercase `item` the arrow uses above (arrows are a different entity
# class) — matching the wrong case silently claims nothing. NOTE: the 26.2 potion entity split means
# splash and lingering are separate types (formerly one `potion`). We do NOT claim the
# area_effect_cloud a lingering potion leaves — the cloud carries only potion_contents, not our
# custom_data, and it stays put + expires on its own, so only the fast thrown projectile can escape.
tag @e[type=splash_potion,tag=!summit.booth_entity.imperium,nbt={Item:{components:{"minecraft:custom_data":{imperium_kit:1b}}}}] add summit.booth_entity.imperium
tag @e[type=lingering_potion,tag=!summit.booth_entity.imperium,nbt={Item:{components:{"minecraft:custom_data":{imperium_kit:1b}}}}] add summit.booth_entity.imperium

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
