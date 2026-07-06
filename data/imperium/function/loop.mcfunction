#### LOOP FILE ####

# booth kit-selection stands -> moved to the 5-tick loop (imperium:5t); see the #t5 clock below

# ability cooldown engine -> now advancement-driven (imperium:combat/cooldown_dealt + cooldown_taken
#   -> imperium:internal/cooldown_{dealt,taken} -> update_cooldowns). Runs only on damage events,
#   so it's off the per-tick loop entirely.

# Smokey's Abilities

    # Smokey (per-tick, kit online): grapple + smoke clouds + convert dart Bad Omen -> im.marked
    execute if entity @a[tag=im.kit_smokey] run function imperium:kits/smokey/loop_kit

# Mummy's Abilities

    # Grappling Rod (Mummy): "get over here" — track cast bobbers and, on reel-in, yank the hooked
    # entity to the Mummy (reverse of Smokey, who pulls himself in). Gated on a Mummy online.
    execute if entity @a[tag=im.kit_mummy] run function imperium:kits/mummy/mgrapple_track

    # Energy meter + Golem Throw wind-up (per-player) -> kits/mummy/loop_kit
    execute as @a[tag=im.kit_mummy] at @s run function imperium:kits/mummy/loop_kit

    # Crystal Bomb (Mummy): a sneak-placed Energy Crystal (crystal_bomb summons it). Start the fuse on
    # freshly placed bombs, tick it down, and remove the crystal on expiry (detonation AoE added next
    # step). Operates on the bomb entities, so it keeps ticking even if the placer leaves.
    execute as @e[type=end_crystal,tag=im.crystal_bomb,tag=!im.bomb_live] run function imperium:kits/mummy/bomb_init
    scoreboard players remove @e[type=end_crystal,tag=im.bomb_live] im_bombFuse 1
    execute as @e[type=end_crystal,tag=im.bomb_live,scores={im_bombFuse=..0}] at @s run function imperium:kits/mummy/bomb_detonate

# Use-remainder placeholder cleanup
    # The Recoil Rod and Reversal Shield carry a use_remainder that drops a same-type stand-in
    # (custom_data imperium_clearme:1b) when the item breaks, so a breaking use is still detected
    # for one moment (the rod still reads as a kit fishing_rod, the shield still has the enchant)
    # and the ability fires on that final use. Strip the stand-ins afterward so a "broken" rod or
    # shield can't be re-cast/re-blocked while it waits for its cooldown re-give.
    # ORDER: must run AFTER grapple_track above, which relies on the rod stand-in to fire the launch.
    # Only the Recoil Rod (fishing_rod) and Reversal Shield (shield) ever carry imperium_clearme,
    # so match those two types explicitly. A wildcard `*[custom_data~{...}]` forces the game to
    # encode the custom_data component of EVERY item in EVERY inventory each tick (a kit loadout is
    # ~9 custom_data items) — that was a large chunk of the per-tick serialization cost.
    clear @a fishing_rod[custom_data~{imperium_clearme:1b}]
    clear @a shield[custom_data~{imperium_clearme:1b}]

    # Smokey Mark timer — mark_apply + smoke clouds moved into smokey/loop_kit (kit-online gated);
    # the timer persists on victims after Smokey leaves, so it stays ungated here.
    function imperium:kits/smokey/mark_tick

# Livvy's Abilities

    # Venom (Livvy): the Venom Spray's Poison III is just the delivery signal; convert it to the
    # tracked im.venom tag and tick it as no-impact imperium:venom damage — keeps the smooth
    # no-impact poison without globally tagging vanilla magic damage.
    execute if entity @a[tag=im.kit_livvy] as @a if predicate imperium:has_venom run function imperium:kits/livvy/venom_apply
    function imperium:kits/livvy/venom_tick

    # Web Throw (Livvy): a thrown web potion lands as an area_effect_cloud (custom_color 14737632);
    # convert each fresh one into a cobweb block display (the real, blockless web). Then tick each
    # web's 3s life, hold any non-Livvy victim inside it, and despawn it when expired.
    execute \
        as @e[type=area_effect_cloud,nbt={potion_contents:{custom_color:14737632}}] \
        at @s \
        run function imperium:kits/livvy/web_init

    scoreboard players remove @e[type=block_display,tag=im.web,scores={im_webLife=1..}] im_webLife 1
    
    execute as @e[type=block_display,tag=im.web] at @s run function imperium:kits/livvy/web_apply
    
    kill @e[type=block_display,tag=im.web,scores={im_webLife=..0}]
    # Release victims (mobs or players) who have left every web (heartbeat watchdog, mirrors
    # high_jump's cleanup). Must be @e so webbed mobs get freed too, not just players.
    scoreboard players remove @e[type=!#im.not_mob,tag=im.webbed,scores={im_webbed=1..}] im_webbed 1
    
    execute as @e[type=!#im.not_mob,tag=im.webbed,scores={im_webbed=0}] run function imperium:kits/livvy/web_release
    # Keep Livvy's web charge count synced to her real remaining web potions (count-based stock).
    
    execute as @a[tag=im.kit_livvy] at @s run function imperium:kits/livvy/loop_kit

# Rastus's Abilities (per-player) -> kits/rastus/loop_kit
    execute as @a[tag=im.kit_rastus] at @s run function imperium:kits/rastus/loop_kit

# Levent's Abilities
    # Charge functions moved to enchantment/charge_attack.json and function/levent/charge_timer.mcfunction


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

# combat round stats: bank regained health for the "damage healed" stat. Gated on im.fighting
# (local stand-in for summit.battlegrounds.player). Move to arena ticking once that's decided.
    execute as @a[tag=im.fighting] run function imperium:arena/track_healed
    # gold rush death penalty: deathCount ticked up -> forfeit half gold (once, then re-arm)
    execute as @a[tag=im.fighting,scores={im_deaths=1..}] run function imperium:arena/on_death

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