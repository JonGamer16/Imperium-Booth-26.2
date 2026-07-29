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

# Grapple rod break signal — consume
    # im.rod_broke (set by imperium:internal/rod_broke off minecraft:item_durability_changed) is how
    # both grapple trackers tell "the reel that broke the rod" apart from "the player swapped the rod
    # out of the offhand": the rod is missing in both cases, but only a break sets the tag. Drop it
    # here, once, now that both trackers have read it — otherwise a break with no grapple armed would
    # leave it set and mis-read some later cancel as a break.
    # ORDER: must run AFTER smokey/loop_kit (-> grapple_track) and mummy/mgrapple_track above.
    tag @a[tag=im.rod_broke] remove im.rod_broke

# Use-remainder placeholder cleanup — REMOVED (both stand-ins were dead code).
    # The Recoil Rod and Reversal Shield each carried a use_remainder that was supposed to drop a
    # same-type stand-in (custom_data imperium_clearme:1b) when the item broke, so the ability could
    # still fire on that final use; this loop then swept the stand-ins. use_remainder never fires on
    # a durability break — it only fires when a stack COUNT decreases after use (soup -> bowl) — so
    # no stand-in was ever created and both sweeps were scanning for nothing every tick.
    #   Rod:    replaced by the im.rod_broke signal above.
    #   Shield: needed nothing. enchantments/reversal_block has no item condition and
    #           enchantments/wip_reversal gates on the im.kit_levent tag rather than the shield, so
    #           the breaking block already fires the reversal on its own.

    # Smokey Mark timer — mark_apply + smoke clouds moved into smokey/loop_kit (kit-online gated);
    # the timer persists on victims after Smokey leaves, so it stays ungated here.
    function imperium:kits/smokey/mark_tick

# Livvy's Abilities

    # Venom (Livvy): the Venom Spray's Poison III is just the delivery signal; convert it to the
    # tracked im.venom tag and tick it as no-impact imperium:venom damage — keeps the smooth
    # no-impact poison without globally tagging vanilla magic damage.
    execute if entity @a[tag=im.kit_livvy] as @a[predicate=imperium:ability_zone] if predicate imperium:has_venom run function imperium:kits/livvy/venom_apply
    function imperium:kits/livvy/venom_tick

    # Web Throw (Livvy): a thrown web potion lands as an area_effect_cloud (custom_color 14737632);
    # convert each fresh one into a cobweb block display (the real, blockless web). Then tick each
    # web's 3s life, hold any non-Livvy victim inside it, and despawn it when expired.
    # in_bounds gate: only convert clouds inside our allowed area. This both contains the web (no web
    # spawns outside the arena/booth) and, because a foreign booth's cloud sits in its own region
    # outside our bounds, stops us converting another booth's same-color lingering cloud into our web.
    execute \
        as @e[type=area_effect_cloud,nbt={potion_contents:{custom_color:14737632}}] \
        at @s \
        if predicate imperium:in_bounds \
        run function imperium:kits/livvy/web_init

    scoreboard players remove @e[type=block_display,tag=im.web,scores={im_webLife=1..}] im_webLife 1
    
    execute as @e[type=block_display,tag=im.web] at @s run function imperium:kits/livvy/web_apply
    
    kill @e[type=block_display,tag=im.web,scores={im_webLife=..0}]
    # Release victims (mobs or players) who have left every web (heartbeat watchdog, mirrors
    # high_jump's cleanup). Must be @e so webbed mobs get freed too, not just players.
    scoreboard players remove @e[type=#imperium:human,tag=im.webbed,scores={im_webbed=1..}] im_webbed 1
    
    execute as @e[type=#imperium:human,tag=im.webbed,scores={im_webbed=0}] run function imperium:kits/livvy/web_release
    # Keep Livvy's web charge count synced to her real remaining web potions (count-based stock).
    
    execute as @a[tag=im.kit_livvy] at @s run function imperium:kits/livvy/loop_kit

# Rastus's Abilities (per-player) -> kits/rastus/loop_kit
    execute as @a[tag=im.kit_rastus] at @s run function imperium:kits/rastus/loop_kit

# Levent's Abilities
    # Charge functions moved to enchantment/charge_attack.json and function/levent/charge_timer.mcfunction
    execute as @a[tag=im.kit_levent] at @s run function imperium:kits/levent/loop_kit


# Training dummy damage indicator: sample each dummy husk's HP drop (= exact hit damage; the husk
# carries no regen to muddy it) and float the number, then age/rise/expire the spawned labels.
    execute as @e[type=husk,tag=im.dummy] at @s run function imperium:booth/dummy/dmg_tick
    scoreboard players remove @e[type=text_display,tag=im.dmg_ind] im_indLife 1
    execute as @e[type=text_display,tag=im.dmg_ind] at @s run tp @s ~ ~0.05 ~
    kill @e[type=text_display,tag=im.dmg_ind,scores={im_indLife=..0}]

# Entity containment: claim vanilla kit projectiles as booth-owned, then kill any owned mobile
# ability entity (arrows, grapple bobbers) that has left the allowed area (booth + arena + corridor).
function imperium:internal/contain

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