#### 1-SECOND LOOP ####

# The kit-equip rate limit (im.equip_cd) is NO LONGER released here. Kit selection must not depend
# on this loop: loop_1s does not run while a player is at the kit stands with no battlegrounds
# session live, so the tag was set on their first ever stand click and never cleared, silently
# refusing every kit they picked after it. Each click now schedules its own release —
# see imperium:booth/equip_cd_clear. Do not add a second owner for that tag here.

# Straight Flight: despawn no-gravity arrows that have exceeded flight time. Booth-owned only
# (summit.booth_entity.imperium, stamped on our kit arrows by imperium:internal/contain) so we never
# age or cull another booth's — or a vanilla — arrow.
scoreboard players add @e[type=#minecraft:arrows,tag=summit.booth_entity.imperium] im_arrowAge 1
kill @e[type=#minecraft:arrows,tag=summit.booth_entity.imperium,scores={im_arrowAge=10..}]

# Training dummy, clean removal: no home marker within 13 blocks -> kill it (kill the marker =
# dummy gone). Was in loop_5t next to the tether; janitor work like this doesn't need 4 scans a
# second, and this loop is booth-scoped the same way. The 13 must stay in step with the tether's
# outer bound in loop_5t, or a dummy in the gap would neither snap back nor die. `#minecraft:zombies`
# rather than `type=husk` so a dummy that converted in water is still matched — see
# booth/dummy/kill_husk.
execute as @e[type=#minecraft:zombies,tag=im.dummy] at @s unless entity @e[type=marker,tag=im.dummy_home,distance=..13] run kill @s


# Arena regen policy, re-asserted. arena/start_round adds summit.no_regen and arena/end_round
# removes it alongside im.fighting, so "im.fighting => summit.no_regen" is an invariant this booth
# owns — but nothing re-established it if the tag was lost mid-match, and losing it is silent AND
# unrecoverable on its own. Summit's regen tick (summit.regen:zz/tick) tops a player's food back up
# only on the summit.no_regen branch; its fallback branch explicitly excludes
# summit.battlegrounds.player. So a fighter without the tag matches NEITHER branch and gets no
# hunger policy at all — food drains and never comes back, and no kit item can fix it because every
# imperium healing item is deliberately nutrition:0 / saturation:0. Anything that strips player tags
# (#summit:api/reset_player on a /hub, /unstuck or rejoin; another booth's cleanup) triggers it.
# One tag test a second makes the invariant self-healing.
tag @a[tag=im.fighting,tag=!summit.no_regen] add summit.no_regen

# gold rush: keep each fighter's im_gold current (for the live display / standings)
execute as @a[tag=im.fighting] run function imperium:arena/calc_gold
# gold rush: personal "[Kill Score] +3 Gold" chat for new kills
execute as @a[tag=im.fighting] run function imperium:arena/gold_kill_bonus
# gold rush: refresh the spectator standings billboard (self-guards if no board is spawned)
function imperium:arena/board_update
# gold rush: decay the kill-feed last-attacker credit window
scoreboard players remove @a[tag=im.fighting,scores={im_lastAtkTime=1..}] im_lastAtkTime 1