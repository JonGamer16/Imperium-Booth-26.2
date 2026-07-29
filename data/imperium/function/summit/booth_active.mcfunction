# BG hook (#summit.battlegrounds:api/booth_active) — our session just became active. Battlegrounds
# rotates booths while players stay inside, so anyone already in the arena at rotation never got a
# player_enter event and thus no kit + no im.fighting (which every kit ability is gated on). Run the
# normal entry setup for every current fighter who isn't already tracked. Symmetric to
# booth_inactive, which ends all im.fighting players when our session closes.
execute unless data storage summit.battlegrounds:database session{booth_id:"imperium"} run return 0

# Reuse player_enter per already-present player so the setup can't drift from a real entry. The
# !im.fighting guard keeps a stray re-activation from re-rolling an active fighter's round.
# #rotation marks this as a rotation rather than a real entry: these players' outside inventory was
# already dealt with when they first entered the arena (cached by whoever kitted them, or lost to
# BG's clear_items), so player_enter must NOT re-cache what they're holding now — see inv_cache.
scoreboard players set #rotation im.temp 1
execute as @a[tag=summit.battlegrounds.player,tag=!im.fighting] run function imperium:summit/player_enter
scoreboard players set #rotation im.temp 0
