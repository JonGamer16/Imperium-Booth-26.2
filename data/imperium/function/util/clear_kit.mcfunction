clear @s *[custom_data~{imperium_kit:1b}]
clear @s *[custom_data~{imperium_healing:1b}]

# Reset ability cooldown/charge/freeze state so the next kit starts clean (no stale
# soft-freeze, and no leftover cd that Livvy's `+=` refill would compound).
# The new kit's cd functions re-set cd + charges + floors for its own wired slots.
scoreboard players set @s im_abilityCdA 0
scoreboard players set @s im_abilityCdB 0
scoreboard players set @s im_abilityCdC 0
scoreboard players set @s im_cdUsesA 0
scoreboard players set @s im_cdUsesB 0
scoreboard players set @s im_cdUsesC 0
scoreboard players set @s im_cdFloorA 0
scoreboard players set @s im_cdFloorB 0
scoreboard players set @s im_cdFloorC 0
scoreboard players set @s im_cdMaxA 0
scoreboard players set @s im_cdMaxB 0
scoreboard players set @s im_cdMaxC 0

tag @s remove im.kit_cliffshield
tag @s remove im.kit_levent
tag @s remove im.kit_livvy
tag @s remove im.kit_meowdy
tag @s remove im.kit_mummy
tag @s remove im.kit_rastus
tag @s remove im.kit_smokey