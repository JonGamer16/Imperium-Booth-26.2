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

# Smokey

    # Smokey Grappling Rod — drop any in-flight grapple state so a kit swap mid-cast can't carry a
    # stale armed launch onto the next kit (the bobber retracts when clear_kit removes the rod above).
    tag @s remove im.grapple_user
    tag @s remove im.grapple_armed
    tag @s remove im.grapple_live

    # Crosshair tracker (Rastus Focus / Levent Charge) — kill this player's paired interaction so
    # a kit swap can't strand it; the enchant's tick re-binds if the new kit also carries one.
    function imperium:enchantments/aim_free

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
    attribute @s minecraft:gravity modifier remove im_high_jump
    scoreboard players set @s im_leventCharge 0
    advancement revoke @s only imperium:levent_shield

    # High Jump — strip the low-gravity modifier via the canonical off function (its remove is
    # guaranteed to match the id high_jump_on added) and clear the equip heartbeat.
    function imperium:enchantments/high_jump_off
    scoreboard players reset @s im_high_jump_eq

# Livvy

    # Web Throw — drop the cobweb clamp if this player was webbed, so a swap can't leave the
    # movement/air-drag modifiers stuck on the new kit. (Webs already in the world expire on their own.)
    tag @s remove im.webbed
    attribute @s minecraft:movement_speed modifier remove imperium:web
    attribute @s minecraft:air_drag_modifier modifier remove imperium:web
    scoreboard players set @s im_webbed 0

# Mummy

    # Grappling Rod — drop any in-flight grapple state so a kit swap mid-cast can't carry a stale
    # armed reel onto the next kit (mirrors the Smokey grapple cleanup above).
    tag @s remove im.mgrapple_user
    tag @s remove im.mgrapple_live
    tag @s remove im.mgrapple_armed

    # Energy meter — empty the pool so a swap can't carry banked energy onto the next kit (the new
    # kit's givekit re-seeds it for its own wired slots; Mummy's resets it to #MummyEnergyStart).
    scoreboard players set @s im_energy 0

    # Energy Barrier — drop any raised barrier so a swap can't leave absorption hearts / the cap stuck.
    tag @s remove im.barrier_up
    attribute @s minecraft:max_absorption modifier remove imperium:barrier
    data modify entity @s AbsorptionAmount set value 0f

    # Golem Throw — clear the wind-up/armed state so a swap can't carry a charged heavy hit onto the
    # next kit (the enchant leaves with the mace; only the scores/tag need wiping here).
    scoreboard players set @s im_golemCharge 0
    scoreboard players set @s im_golemReady 0
    tag @s remove im.golem_armed