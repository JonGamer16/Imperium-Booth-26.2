# Booth kit-stand interaction handler — runs every tick from imperium:loop.
#
# Each kit display is an `interaction` entity tagged im.booth_stand + im.booth_<kit>,
# overlapping a Marker armor_stand that shows the kit's gear. When a player right-clicks
# the interaction entity it gains an `interaction` NBT compound; we route it as the
# nearest player and clear the click so it only fires once.
#   - sneak + click -> that kit's booth/lore (hidden fighter lore)
#   - plain click   -> that kit's booth/select (equip the kit + show abilities)
#
# NOTE: targets @p within range rather than the exact UUID stored in interaction.player
# (which is awkward to resolve to a selector). In a booth one player clicks at a time
# standing adjacent, so nearest-player is reliable here.

execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_cliffshield] at @s if data entity @s interaction as @p[distance=..4] if predicate imperium:sneaking run function imperium:kits/cliffshield/booth/lore
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_cliffshield] at @s if data entity @s interaction as @p[distance=..4] unless predicate imperium:sneaking run function imperium:kits/cliffshield/booth/select
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_meowdy] at @s if data entity @s interaction as @p[distance=..4] if predicate imperium:sneaking run function imperium:kits/meowdy/booth/lore
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_meowdy] at @s if data entity @s interaction as @p[distance=..4] unless predicate imperium:sneaking run function imperium:kits/meowdy/booth/select
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_livvy] at @s if data entity @s interaction as @p[distance=..4] if predicate imperium:sneaking run function imperium:kits/livvy/booth/lore
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_livvy] at @s if data entity @s interaction as @p[distance=..4] unless predicate imperium:sneaking run function imperium:kits/livvy/booth/select
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_mummy] at @s if data entity @s interaction as @p[distance=..4] if predicate imperium:sneaking run function imperium:kits/mummy/booth/lore
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_mummy] at @s if data entity @s interaction as @p[distance=..4] unless predicate imperium:sneaking run function imperium:kits/mummy/booth/select
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_levent] at @s if data entity @s interaction as @p[distance=..4] if predicate imperium:sneaking run function imperium:kits/levent/booth/lore
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_levent] at @s if data entity @s interaction as @p[distance=..4] unless predicate imperium:sneaking run function imperium:kits/levent/booth/select
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_rastus] at @s if data entity @s interaction as @p[distance=..4] if predicate imperium:sneaking run function imperium:kits/rastus/booth/lore
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_rastus] at @s if data entity @s interaction as @p[distance=..4] unless predicate imperium:sneaking run function imperium:kits/rastus/booth/select
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_smokey] at @s if data entity @s interaction as @p[distance=..4] if predicate imperium:sneaking run function imperium:kits/smokey/booth/lore
execute as @e[type=interaction,tag=im.booth_stand,tag=im.booth_smokey] at @s if data entity @s interaction as @p[distance=..4] unless predicate imperium:sneaking run function imperium:kits/smokey/booth/select

# Consume the click on every booth stand so a single right-click fires once.
execute as @e[type=interaction,tag=im.booth_stand] run data remove entity @s interaction
