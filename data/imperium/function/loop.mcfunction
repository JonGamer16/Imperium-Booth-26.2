#### LOOP FILE ####

# booth kit-selection stands -> moved to the 5-tick loop (imperium:5t); see the #t5 clock below

# ability cooldown engine -> now advancement-driven (imperium:combat/cooldown_dealt + cooldown_taken
#   -> imperium:internal/cooldown_{dealt,taken} -> update_cooldowns). Runs only on damage events,
#   so it's off the per-tick loop entirely.

# Smokey's Abilities

    # Grappling Rod (Smokey): track cast bobbers and launch the angler on reel-in. Gated so the
    # @e[fishing_bobber] scan only runs while a Smokey is online.
    execute if entity @a[tag=im.kit_smokey] run function imperium:kits/smokey/grapple_track

# Use-remainder placeholder cleanup
    # The Recoil Rod and Reversal Shield carry a use_remainder that drops a same-type stand-in
    # (custom_data imperium_clearme:1b) when the item breaks, so a breaking use is still detected
    # for one moment (the rod still reads as a kit fishing_rod, the shield still has the enchant)
    # and the ability fires on that final use. Strip the stand-ins afterward so a "broken" rod or
    # shield can't be re-cast/re-blocked while it waits for its cooldown re-give.
    # ORDER: must run AFTER grapple_track above, which relies on the rod stand-in to fire the launch.
    clear @a *[custom_data~{imperium_clearme:1b}]

    # Smoke Bomb (Smokey): configure freshly-thrown clouds, then emit one puff
    execute \
        as @e[type=area_effect_cloud,tag=!im.smoke_bomb,nbt={potion_contents:{custom_color:1973790}}] \
        at @s \
        run function imperium:kits/smokey/smoke_init
    # Smoke Bomb: grant invis + speed to Smokey players inside active clouds
    execute \
        as @e[type=area_effect_cloud,tag=im.smoke_bomb] \
        at @s \
        run function imperium:kits/smokey/smoke_apply

    # Marking Dart (Smokey): the dart applies Bad Omen purely as an on-hit signal; convert any
    # hit player to the tracked im.marked tag (Summit wants a tag, not a status effect), then
    # tick the tag's 10s timer, expiry, and red marker particle.
    execute \
        as @a \
        if predicate imperium:has_bad_omen \
        run function imperium:kits/smokey/mark_apply
    function imperium:kits/smokey/mark_tick

# Livvy's Abilities

    # Venom (Livvy): the Venom Spray's Poison III is just the delivery signal; convert it to the
    # tracked im.venom tag and tick it as no-impact imperium:venom damage — keeps the smooth
    # no-impact poison without globally tagging vanilla magic damage.
    execute as @a if predicate imperium:has_venom run function imperium:kits/livvy/venom_apply
    function imperium:kits/livvy/venom_tick

# Rastus's Abilities

    # Superior Agility (Rastus): air dodge is advancement-driven. imperium:rastus_air_dodge earns
    # while a Rastus player holds sneak airborne and runs the launch; the earned advancement is
    # the once-per-airtime lock. Re-arm it on the ground so each airtime gets exactly one dodge.
    execute \
        as @a[tag=im.kit_rastus] \
        at @s \
        if predicate imperium:on_ground \
        run advancement revoke @s only imperium:rastus_air_dodge

    # Strike & Parry (Rastus): shared charge = idle ticks since the last melee. attack_player's
    # reset_drought zeroes it on a landed hit; the parry reward zeroes it on a shield raise. At
    # >= #StrikeCharge (0.6s) the rapier Strike and the shield Parry are armed.
    scoreboard players add @a[tag=im.kit_rastus] im_melee_drought 1

    # Parry full-deflect bubble: tick the window down; when it closes, strip Resistance/KB resist.
    execute \
        as @a[tag=im.kit_rastus,scores={im_parryWindow=1..}] \
        run scoreboard players remove @s im_parryWindow 1
    execute \
        as @a[tag=im.kit_rastus,scores={im_parryWindow=0}] \
        run function imperium:kits/rastus/parry_close

    # Strike (Rastus): arm the rapier boost the tick the shared charge completes; strip it once
    # the charge is gone (a landed hit via reset_focus, a parry, or any other drought reset).
    execute \
        as @a[tag=im.kit_rastus,tag=!im.rastus_focused] \
        if score @s im_melee_drought >= #StrikeCharge im.param \
        run function imperium:kits/rastus/focus_on
    execute \
        as @a[tag=im.kit_rastus,tag=im.rastus_focused] \
        unless score @s im_melee_drought >= #StrikeCharge im.param \
        run function imperium:kits/rastus/focus_off

# Levent's Abilities

    # Charge Attack (Levent): charge = idle ticks since the last rod jab OR shield raise. A jab
    # (Charge Attack enchant's post_piercing_attack -> charge_spend, fires on hit AND whiff) and a
    # shield raise (levent_shield -> charge_block) both zero it. At >= #LeventCharge the boost arms;
    # the next jab spends it and charge_off strips the bonus the following tick — so a whiff wastes
    # the charge. Mirrors Rastus's Strike.
    scoreboard players add @a[tag=im.kit_levent] im_leventCharge 1
    execute \
        as @a[tag=im.kit_levent,tag=!im.levent_charged] \
        if score @s im_leventCharge >= #LeventCharge im.param \
        run function imperium:kits/levent/charge_on
    execute \
        as @a[tag=im.kit_levent,tag=im.levent_charged] \
        unless score @s im_leventCharge >= #LeventCharge im.param \
        run function imperium:kits/levent/charge_off


# Enchantments

    # High Jump: strip the orphaned low-gravity modifier when the armor is unequipped mid-jump.
    #   The enchant's tick refreshes im_high_jump_eq to 2 every tick it's worn. Here we tick that
    #   down ONLY for players currently in high-jump gravity (im_high_jump=1) — a tiny set — and
    #   when it reaches 0 (no enchant tick for 2 ticks = unequipped) we remove the leftover modifier.
    scoreboard players remove @a[scores={im_high_jump=1,im_high_jump_eq=1..}] im_high_jump_eq 1
    execute as @a[scores={im_high_jump=1,im_high_jump_eq=0}] run function imperium:enchantments/high_jump_off

# 5-tick loop (for local testing; booth uses ticking_functions at "5t")
    scoreboard players add #t5 im_5tTimer 1
    execute if score #t5 im_5tTimer matches 5.. run function imperium:loop_5t
    execute if score #t5 im_5tTimer matches 5.. run scoreboard players set #t5 im_5tTimer 0

# 1-second loop (for local testing; booth uses ticking_functions at "1s")
    scoreboard players add #sec im_secTimer 1
    execute if score #sec im_secTimer matches 20.. run function imperium:loop_1s
    execute if score #sec im_secTimer matches 20.. run scoreboard players set #sec im_secTimer 0


# ===== OLD SYSTEMS =====

# Leaving Spawn and Givekit
    # execute \
    #     as @a[advancements={imperium:leave_spawn=false}] \
    #     unless predicate imperium:at_spawn \
    #     run advancement grant @s only imperium:leave_spawn
    # execute \
    #     as @a[advancements={imperium:leave_spawn=true}] \
    #     if predicate imperium:at_spawn \
    #     run advancement revoke @s only imperium:leave_spawn

    # scoreboard players enable @s[advancements={imperium:leave_spawn=false}] givekit

# item drop proofing (for old soup dropping)
    #execute at @e[type=item] run tp @e[limit=1,type=item,distance=..1] @p
    #execute at @e[type=item] run data merge entity @e[limit=1,type=item,distance=..1] {PickupDelay:0}

# givekit engine
    # execute as @a[scores={givekit=1..},advancements={imperium:leave_spawn=false}] run function imperium:arena/givekit

# TODO: Optimize by turning all the below item reload functions into 1 function that checks for itemreload
    # How: Replace all checks of one itemreload threshold with a single function checking for the itemreload score
    #   and a tag players get for their item
    # What: This will limit item refill bars to 30 damage but also save lines on the loop
    # Pro Fix: To add variation in item refill, there will be 2 layers of branching functions controlling refills.
    #   Here it'll have to check for a refillMeterA, refillMeterB, or refillMeterC player tag, then the
    #   proper itemreload score minimum to go with it. Instead of 1 new check per new item, it'll check a limited
    #   set of tags and scores, then run the branching function for that set of items.

# item reload engine
    # CONFLICT NOTE: itemreload and im_abilityDealt both use custom:damage_dealt but are separate
    #   objectives — resetting im_abilityDealt each tick does NOT affect itemreload accumulation.
    #   Remove itemreload, item_distributor_300, and rTotem checks once ability system replaces them.
    # execute as @a[scores={itemreload=300..}] in overworld run function imperium:arena/item_distributor_300
    # execute as @a[scores={rTotem=1..,itemreload=600..}] in overworld run function imperium:items/totem

    # soup drop engine (old)
        #execute at @e[type=item,nbt={Item:{id:"minecraft:beetroot_soup"}}] run function imperium:soup/beet_soup_drop
        #execute at @e[type=item,nbt={Item:{id:"minecraft:mushroom_stew"}}] run function imperium:soup/mush_soup_drop
        #execute at @e[type=item,nbt={Item:{id:"minecraft:rabbit_stew"}}] run function imperium:soup/rabbit_soup_drop

# arena mechanics (old)
    # execute as @a[scores={killFlag=1..}] run function imperium:arena/kill
    # execute as @a[scores={onDeath=1..}] run function imperium:arena/death
    # execute as @a[scores={onLeave=1..}] run function imperium:arena/death
    # execute \
    #     store result score @s im_hp \
    #     run data get entity @s \
    #         Health 1000

# WIP TESTING
    #execute as @e[tag=im_rot_track] run function imperium:data_fetching/get_rotation

    # execute as JonGamer16 run \
    #     execute store result score NearestCow im_rotation run data get entity @n[type=cow,distance=0..5] Rotation[0] 1

    #execute as @a[scores={carrot_on_a_stick=1..}] run function imperium:raycaster/proxy