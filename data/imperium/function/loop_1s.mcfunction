#### 1-SECOND LOOP ####

# The kit-equip rate limit (im.equip_cd) is NO LONGER released here. Kit selection must not depend
# on this loop: loop_1s does not run while a player is at the kit stands with no battlegrounds
# session live, so the tag was set on their first ever stand click and never cleared, silently
# refusing every kit they picked after it. Each click now schedules its own release —
# see imperium:booth/equip_cd_clear. Do not add a second owner for that tag here.

# Straight Flight: despawn no-gravity arrows that have exceeded flight time. Booth-owned only
# (im.owned, stamped on our kit arrows by imperium:internal/contain) so we never
# age or cull another booth's — or a vanilla — arrow.
scoreboard players add @e[type=#minecraft:arrows,tag=im.owned] im_arrowAge 1
kill @e[type=#minecraft:arrows,tag=im.owned,scores={im_arrowAge=10..}]

# Training dummy, clean removal: no home marker within 13 blocks -> kill it (kill the marker =
# dummy gone). Was in loop_5t next to the tether; janitor work like this doesn't need 4 scans a
# second, and this loop is booth-scoped the same way. The 13 must stay in step with the tether's
# outer bound in loop_5t, or a dummy in the gap would neither snap back nor die. `#minecraft:zombies`
# rather than `type=husk` so a dummy that converted in water is still matched — see
# booth/dummy/kill_husk.
execute as @e[type=#minecraft:zombies,tag=im.dummy] at @s unless entity @e[type=marker,tag=im.dummy_home,distance=..13] run kill @s


# Regen policy. Every imperium healing item is deliberately nutrition:0 / saturation:0, so healing
# is supposed to come only from the kit — which means vanilla's natural regeneration has to be off
# or it quietly heals through the whole design. Summit did this with summit.no_regen plus its own
# regen tick (summit.regen:zz/tick) that also held a tagged player's food at 8. Neither exists here.
#
# Standalone the switch is the natural_health_regeneration gamerule, set once in imperium:main. It is
# WORLD-WIDE, which is correct for a dedicated kit-PVP world and wrong for anything else. That's why
# it belongs to the kit PvP pack only (SPLIT_PLAN.md); one game mode per world.
#
# im.no_regen survives as the marker for "this player is on artificial healing", so anything that
# wants to hand back regen (a lobby, a spectator mode) has a tag to test rather than a gamerule to
# fight. It tracks im.fighting, self-healing once a second the way the Summit invariant did.
#
# Saturation is topped up rather than left to drain: with natural regen off, food no longer heals,
# but an empty bar still blocks sprinting. One short effect a second holds it full without giving
# back any healing.
tag @a[tag=im.fighting,tag=!im.no_regen] add im.no_regen
tag @a[tag=!im.fighting,tag=im.no_regen] remove im.no_regen
effect give @a[tag=im.no_regen] minecraft:saturation 2 0 true

# gold rush: keep each fighter's im_gold current (for the live display / standings)
execute as @a[tag=im.fighting] run function imperium:arena/calc_gold
# gold rush: personal "[Kill Score] +3 Gold" chat for new kills
execute as @a[tag=im.fighting] run function imperium:arena/gold_kill_bonus
# gold rush: decay the kill-feed last-attacker credit window
scoreboard players remove @a[tag=im.fighting,scores={im_lastAtkTime=1..}] im_lastAtkTime 1
# Deferred kit re-give after death. arena/on_death tags the corpse and leaves; this waits until the
# player has actually respawned (Health back above 0) before handing the kit back, so the re-give
# can't be eaten by the vanilla respawn wipe. Cheap: the tag only exists between a death and the
# respawn that follows it.
execute as @a[tag=im.await_kit] unless entity @s[nbt={Health:0.0f}] run function imperium:arena/respawn
