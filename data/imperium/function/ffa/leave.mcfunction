# Leave the fight. Called as the player from imperium:booth/enter_booth — i.e. on the RISING edge of
# imperium:safe_zone, the moment they set foot back on the spawn island.
#
# REPLACES arena/end_round + summit/end_fighter + the #summit.battlegrounds:api/player_leave hook,
# all parked in zz_archive. Notably it does NOT take the kit away: imperium:ability_zone is now
# "is holding a kit", so the kit is yours until you hand it back at the Clear Kit stand or pick a
# different one. Nor does it print a post-game stat summary — there is no game to be post of.

execute unless entity @s[tag=im.fighting] run return 0

tag @s remove im.fighting

# Crosshair tracker (Rastus Focus / Levent Charge): this player's paired interaction entity has
# nothing to follow while they are out of the fight. aim_tick re-binds a fresh one on re-entry.
function imperium:enchantments/aim_free
