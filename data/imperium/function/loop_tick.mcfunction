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
    execute as @a[tag=im.kit_levent] at @s run function imperium:kits/levent/loop_kit


# 5-tick loop (for local testing; booth uses ticking_functions at "5t")
    scoreboard players add #t5 im_5tTimer 1
    execute if score #t5 im_5tTimer matches 5.. run function imperium:loop_5t
    execute if score #t5 im_5tTimer matches 5.. run scoreboard players set #t5 im_5tTimer 0

# 1-second loop (for local testing; booth uses ticking_functions at "1s")
    scoreboard players add #sec im_secTimer 1
    execute if score #sec im_secTimer matches 20.. run function imperium:loop_1s
    execute if score #sec im_secTimer matches 20.. run scoreboard players set #sec im_secTimer 0

# gold rush death penalty: deathCount ticked up -> forfeit half gold (once, then re-arm)
    execute as @a[tag=im.fighting,scores={im_deaths=1..}] run function imperium:arena/on_death