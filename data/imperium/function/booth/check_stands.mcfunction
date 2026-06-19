# Booth kit-stand interaction handler — runs every tick from imperium:loop.
#
# Each kit display is an `interaction` entity tagged im.booth_stand + im.booth_<kit>,
# overlapping a Marker armor_stand that shows the kit's gear. When a player right-clicks
# the interaction entity it records that player's UUID; `execute on target` then runs as
# the EXACT player who clicked.
#
# Fixes two playtest bugs in the old "as @p[distance=..4]" routing:
#   1. It re-kitted the NEAREST player, not whoever actually clicked. `on target` is exact.
#   2. Stray right-clicks near a stand (e.g. mid-combat) swapped someone's kit. Selection
#      now only fires while the clicker is at the booth (imperium:at_spawn) — the same
#      spawn/arena boundary the loop already uses to gate givekit/cooldowns.
#   - sneak + click -> that kit's booth/lore (hidden fighter lore)
#   - plain click   -> that kit's booth/select (equip the kit + show abilities)

execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_cliffshield] if data entity @s interaction on target at @s if predicate imperium:at_spawn if predicate imperium:sneaking run function imperium:kits/cliffshield/booth/lore
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_cliffshield] if data entity @s interaction on target at @s if predicate imperium:at_spawn unless predicate imperium:sneaking run function imperium:kits/cliffshield/booth/select
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_meowdy] if data entity @s interaction on target at @s if predicate imperium:at_spawn if predicate imperium:sneaking run function imperium:kits/meowdy/booth/lore
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_meowdy] if data entity @s interaction on target at @s if predicate imperium:at_spawn unless predicate imperium:sneaking run function imperium:kits/meowdy/booth/select
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_livvy] if data entity @s interaction on target at @s if predicate imperium:at_spawn if predicate imperium:sneaking run function imperium:kits/livvy/booth/lore
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_livvy] if data entity @s interaction on target at @s if predicate imperium:at_spawn unless predicate imperium:sneaking run function imperium:kits/livvy/booth/select
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_mummy] if data entity @s interaction on target at @s if predicate imperium:at_spawn if predicate imperium:sneaking run function imperium:kits/mummy/booth/lore
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_mummy] if data entity @s interaction on target at @s if predicate imperium:at_spawn unless predicate imperium:sneaking run function imperium:kits/mummy/booth/select
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_levent] if data entity @s interaction on target at @s if predicate imperium:at_spawn if predicate imperium:sneaking run function imperium:kits/levent/booth/lore
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_levent] if data entity @s interaction on target at @s if predicate imperium:at_spawn unless predicate imperium:sneaking run function imperium:kits/levent/booth/select
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_rastus] if data entity @s interaction on target at @s if predicate imperium:at_spawn if predicate imperium:sneaking run function imperium:kits/rastus/booth/lore
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_rastus] if data entity @s interaction on target at @s if predicate imperium:at_spawn unless predicate imperium:sneaking run function imperium:kits/rastus/booth/select
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_smokey] if data entity @s interaction on target at @s if predicate imperium:at_spawn if predicate imperium:sneaking run function imperium:kits/smokey/booth/lore
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_smokey] if data entity @s interaction on target at @s if predicate imperium:at_spawn unless predicate imperium:sneaking run function imperium:kits/smokey/booth/select

# Consume the click on every booth stand so a single right-click only fires once.
execute as @e[type=interaction,tag=im.booth_stand] run data remove entity @s interaction
