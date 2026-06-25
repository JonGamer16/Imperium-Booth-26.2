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

# Rastus air-dodge (Superior Agility) — revoke so an earned (locked) dodge can't linger on a swap.
advancement revoke @s only imperium:rastus_air_dodge

# Rastus Strike & Parry — strip any open full-deflect bubble and reset the shared charge so a
# swap mid-parry can't leave Resistance/knockback immunity stuck on the new kit.
advancement revoke @s only imperium:raise_shield
attribute @s minecraft:knockback_resistance modifier remove imperium:parry
effect clear @s minecraft:resistance
scoreboard players set @s im_parryWindow -1
scoreboard players set @s im_melee_drought 0
# Strip the Strike (Focus Attack) boost so it can't carry its attack modifiers onto a new kit.
tag @s remove im.rastus_focused
attribute @s minecraft:attack_damage    modifier remove imperium:focus
attribute @s minecraft:attack_speed     modifier remove imperium:focus
attribute @s minecraft:attack_knockback modifier remove imperium:focus
# AV-cue state: clear the parry-window marker and re-arm both cue advancements for a clean kit.
tag @s remove im.rastus_parrying
advancement revoke @s only imperium:rastus_strike_cue
advancement revoke @s only imperium:rastus_parry_cue