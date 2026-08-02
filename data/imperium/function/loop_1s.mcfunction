#### 1-SECOND LOOP ####

# Kit-equip rate limit: booth stand clicks set im.equip_cd and refuse to equip while it's
# present (see kits/*/booth/click + booth/random/click), so clearing it here allows at most
# one full im_givekit pipeline per player per second.
tag @a[tag=im.equip_cd] remove im.equip_cd

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


# gold rush: keep each fighter's im_gold current (for the live display / standings)
execute as @a[tag=im.fighting] run function imperium:arena/calc_gold
# gold rush: personal "[Kill Score] +3 Gold" chat for new kills
execute as @a[tag=im.fighting] run function imperium:arena/gold_kill_bonus
# gold rush: refresh the spectator standings billboard (self-guards if no board is spawned)
function imperium:arena/board_update
# gold rush: decay the kill-feed last-attacker credit window
scoreboard players remove @a[tag=im.fighting,scores={im_lastAtkTime=1..}] im_lastAtkTime 1