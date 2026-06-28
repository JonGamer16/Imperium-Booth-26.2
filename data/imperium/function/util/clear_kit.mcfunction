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

# Smokey

    # Smokey Grappling Rod — drop any in-flight grapple state so a kit swap mid-cast can't carry a
    # stale armed launch onto the next kit (the bobber retracts when clear_kit removes the rod above).
    tag @s remove im.grapple_user
    tag @s remove im.grapple_armed
    tag @s remove im.grapple_live

    tag @s remove im.kit_cliffshield
    tag @s remove im.kit_levent
    tag @s remove im.kit_livvy
    tag @s remove im.kit_meowdy
    tag @s remove im.kit_mummy
    tag @s remove im.kit_rastus
    tag @s remove im.kit_smokey

# Rastus

    # Air-dodge (Superior Agility) — revoke so an earned (locked) dodge can't linger on a swap.
    advancement revoke @s only imperium:rastus_air_dodge

    # Strike & Parry — strip any open full-deflect bubble and reset the shared charge so a
    # swap mid-parry can't leave Resistance/knockback immunity stuck on the new kit.
    advancement revoke @s only imperium:raise_shield
    attribute @s minecraft:knockback_resistance modifier remove imperium:parry
    effect clear @s minecraft:resistance
    scoreboard players set @s im_parryWindow -1
    scoreboard players set @s im_melee_drought 0
    # Strip the Strike (Focus Attack) boost so it can't carry its attack modifiers onto a new kit.
    tag @s remove im.rastus_focused
    attribute @s minecraft:attack_damage modifier remove imperium:focus
    attribute @s minecraft:attack_speed modifier remove imperium:focus
    attribute @s minecraft:attack_knockback modifier remove imperium:focus
    # AV-cue state: clear the parry-window marker and re-arm both cue advancements for a clean kit.
    tag @s remove im.rastus_parrying
    advancement revoke @s only imperium:rastus_strike_cue
    advancement revoke @s only imperium:rastus_parry_cue

# Levent

    # Charge Attack — strip the boost, clear the charge, and re-arm the shield trigger so a swap
    # mid-charge can't carry Levent's attack/reach/knockback modifiers onto the new kit.
    tag @s remove im.levent_charged
    attribute @s minecraft:attack_damage modifier remove imperium:charge
    attribute @s minecraft:entity_interaction_range modifier remove imperium:charge
    attribute @s minecraft:attack_knockback modifier remove imperium:charge
    scoreboard players set @s im_leventCharge 0
    advancement revoke @s only imperium:levent_shield