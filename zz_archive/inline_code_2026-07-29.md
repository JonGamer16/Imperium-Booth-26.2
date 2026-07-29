# Inline code removed from live functions — 2026-07-29

Commented-out code stripped out of `data/` so the shipped pack carries no dead boilerplate
(Summit staff ask for this). Nothing here was running; each snippet is recorded with the file
and line range it came from so it can be put back.

Unlike the parked enchantments beside this file, these are **fragments**, not loadable files —
restore by pasting a snippet back into the named function, not by moving a file.

> **NOTE — kit stand nameplates. Do not restore these.** All seven kit nameplates are now summoned
> as fixed `summit.static` booth entities by `booth/booth_entities/armory.mcfunction`. The
> per-kit nameplates in `kits/<kit>/booth/summon.mcfunction` are the superseded copies — Cliffshield,
> Levent and Livvy had already been commented out, which is what put them in this file. Restoring
> one would double up the label on the stand. The four still-live copies (Meowdy, Mummy, Rastus,
> Smokey) should come out too; see the redundant-display list in the handover notes.

## `imperium/function/abilities/leap.mcfunction`

### lines 5–15

Ground-only leap gate. Per-player im.leap_ground_only tag that refunded the feather on an airborne leap, to disable the jump-first-for-distance technique. Never wired up: nothing adds im.leap_ground_only, and imperium:abilities/leap_refund is still live if you restore this.

```mcfunction
#   Ground-Only Gate
#       Toggle the jump-leap distance technique per player via the im.leap_ground_only tag.
#       No tag  -> free leap (jump first for extra distance).
#       Tagged  -> airborne leaps refund the feather and abort, so only grounded leaps fire.
#       OnGround flips false the instant you jump, which is exactly what blocks the technique.

# execute \
#     if entity @s[tag=im.leap_ground_only] \
#     unless entity @s[nbt={OnGround:1b}] \
#     run return run function imperium:abilities/leap_refund

```

## `imperium/function/arena/respawn.mcfunction`

### lines 7–7

Placeholder mid-round respawn teleport. Still unresolved - see the TODO left in respawn.mcfunction; needs the real arena respawn point(s) and confirmation of whether player_died fires before or after the vanilla respawn.

```mcfunction
# tp @s 0.0 100.0 0.0
```

## `imperium/function/arena/start_round.mcfunction`

### lines 22–25

Health-sample seeding for a healed-delta stat. Superseded by im_statHealed (main/init_stats); im_hpSample and im_hp are not declared anywhere in the live pack.

```mcfunction
# Seed the health sample so the first healed-delta isn't measured from 0.
# execute store result score @s im_hpSample run data get entity @s Health 10
# scoreboard players set @s im_hp 0

```

## `imperium/function/kits/cliffshield/booth/summon.mcfunction`

### lines 18–25

Floating nameplate above the kit stand. STALE: missing the summit.booth_entity.imperium tag that the live meowdy/mummy/rastus/smokey nameplates carry - add it before restoring. See NOTE below.

```mcfunction
# execute at @e[type=armor_stand,tag=im.booth_new,limit=1] \
#     rotated -90 ~ \
#     run summon text_display ^-.75 ^-0.625 ^ \
#     {   text:{text:"Jeru Cliffshield",color:"yellow",bold:true},\
#         billboard:"fixed",\
#         see_through:1b,\
#         Tags:["im.booth_stand_model","im.booth_cliffshield"]\
#     }
```

## `imperium/function/kits/levent/booth/summon.mcfunction`

### lines 18–25

Floating nameplate above the kit stand. Same staleness as cliffshield. See NOTE below.

```mcfunction
# execute at @e[type=armor_stand,tag=im.booth_new,limit=1] \
#     rotated ~ ~ \
#     run summon text_display ^ ^-0.5 ^0.7 \
#     {   text:{text:"Levent",color:"light_purple",bold:true},\
#         billboard:"fixed",\
#         see_through:1b,\
#         Tags:["im.booth_stand_model","im.booth_levent"]\
#     }
```

## `imperium/function/kits/levent/givekit.mcfunction`

### lines 94–99

Levitation Arrow, inline. Superseded by loot_table/levent/arrows via cd1_arrows.

```mcfunction
#item replace entity @s hotbar.8 with \
#    tipped_arrow[\
#        potion_contents={custom_effects:[\
#            {id:"levitation",amplifier:1,duration:50}]},\
#        custom_data={"imperium_kit":1b}\
#    ] 1
```

### lines 103–108

Reversal Shield, inline. Superseded by loot_table/levent/shield via cd2_shield.

```mcfunction
#item replace entity @s weapon.offhand with \
#    shield[\
#        max_damage=30,\
#        custom_name={color:"white",italic:false,text:"Reversal Shield"},\
#        custom_data={"imperium_kit":1b}\
#    ]
```

### lines 116–127

Chorus Fruit healing item, inline. Superseded by loot_table/levent/healing.

```mcfunction
#give @s \
#    chorus_fruit[\
#        max_stack_size=1,\
#        food={nutrition:0,saturation:0,can_always_eat:true},\
#        consumable={\
#            consume_seconds:0,\
#            on_consume_effects:[\
#                {type:"apply_effects",effects:[\
#                    {id:"instant_health",amplifier:1,duration:1}]},\
#                {type:"teleport_randomly",diameter:16}]},\
#        custom_data={imperium_healing:1b}\
#    ] 16
```

## `imperium/function/kits/livvy/booth/summon.mcfunction`

### lines 20–27

Floating nameplate above the kit stand. Same staleness as cliffshield. See NOTE below.

```mcfunction
# execute at @e[type=armor_stand,tag=im.booth_new,limit=1] \
#     rotated ~ ~ \
#     run summon text_display ^ ^-0.5 ^0.7 \
#     {   text:{text:"Livvy",color:"red",bold:true},\
#         billboard:"fixed",\
#         see_through:1b,\
#         Tags:["im.booth_stand_model","im.booth_livvy"]\
#     }
```

## `imperium/function/kits/livvy/givekit.mcfunction`

### lines 82–86

Leap Feather, inline. Superseded by loot_table/livvy/feather via cd1_feather.

```mcfunction
#item replace entity @s weapon.offhand with \
#    feather[\
#        enchantments={"imperium:leap":2},\
#        custom_data={"imperium_kit":1b},\
#    ] 1
```

### lines 101–106

Acid Potion, inline. Superseded by loot_table/livvy/potion via cd3_potion.

```mcfunction
#item replace entity @s hotbar.2 with \
#    splash_potion[\
#        potion_contents={custom_effects:[\
#            {id:"poison",amplifier:2,duration:40}]},\
#        custom_data={"imperium_kit":1b},\
#    ] 1
```

### lines 111–120

Beetroot Soup healing item, inline. Superseded by loot_table/livvy/healing.

```mcfunction
#give @s beetroot_soup\
#    [\
#        food={nutrition:0,saturation:0,can_always_eat:true},\
#        consumable={\
#            consume_seconds:0,\
#            on_consume_effects:[{type:"apply_effects",effects:[\
#                {id:"instant_health",amplifier:0,duration:1}]}]},\
#            use_remainder={"id":"bowl",count:1},\
#        custom_data={"imperium_healing":1b}\
#    ] 20
```

## `imperium/function/kits/meowdy/givekit.mcfunction`

### lines 118–122

Leap Feather, inline. Superseded by loot_table/meowdy/feather via cd1_feather.

```mcfunction
#item replace entity @s weapon.offhand with \
#    feather[\
#        enchantments={"imperium:leap":2},\
#        custom_data={"imperium_kit":1b},\
#    ] 1
```

### lines 141–148

Salmon healing item, inline. Superseded by loot_table/meowdy/healing.

```mcfunction
#give @s cooked_salmon[\
#    max_stack_size=1,\
#    food={nutrition:0,saturation:0,can_always_eat:true},\
#    consumable={\
#        consume_seconds:0,\
#        on_consume_effects:[{type:"apply_effects",effects:[\
#            {id:"instant_health",amplifier:1,duration:1}]}]},\
#    custom_data={"imperium_healing":1b}] 16
```

## `imperium/function/kits/mummy/givekit.mcfunction`

### lines 74–79

Grapple Rod, inline. Superseded by loot_table/mummy/fishing_rod via cd1_rod.

```mcfunction
#item replace entity @s hotbar.1 with \
#    fishing_rod[\
#        enchantments={"imperium:wip_reeling":1},\
#        max_damage=10,\
#        custom_data={"imperium_kit":1b},\
#    ]
```

### lines 88–100

Energy Crystal healing item, inline. Superseded by loot_table/mummy/healing.

```mcfunction
#give @s end_crystal[\
#        !can_place_on,\
#        custom_name="Energy Crystal",\
#        max_stack_size=1,\
#        food={nutrition:0,saturation:0,can_always_eat:true},\
#        consumable={\
#            consume_seconds:0,\
#            on_consume_effects:[{type:"apply_effects",effects:[\
#                {id:"instant_health",amplifier:1,duration:1s},\
#                {id:"regeneration",amplifier:4,duration:2s}]}]},\
#            use_remainder={"id":"bowl",count:1},\
#        custom_data={"imperium_healing":1b}\
#    ] 10
```

## `imperium/function/kits/rastus/givekit.mcfunction`

### lines 81–86

Buckler Shield, inline. Superseded by loot_table/rastus/shield via cd1_shield.

```mcfunction
#item replace entity @s weapon.offhand with \
#    shield[\
#        !max_damage,\
#        custom_name={text:"Buckler Shield",color:blue,italic:false},\
#        custom_data={"imperium_kit":1b},\
#    ]
```

### lines 95–100

Splash Healing potion, inline. Superseded by loot_table/rastus/healing.

```mcfunction
#give @s \
#    potion[\
#        potion_contents={custom_effects:[\
#            {id:"instant_health",amplifier:1,duration:1}]},\
#        custom_data={"imperium_healing":1b}\
#    ] 16
```

## `imperium/function/kits/rastus/parry_cue.mcfunction`

### lines 6–10

Alternative AV cue for a successful Parry (anvil + shield-block + spark/crit particles).

```mcfunction
# playsound minecraft:block.anvil.land     hostile @s ~ ~ ~ 0.4 1.9
# playsound minecraft:item.shield.block    player  @s ~ ~ ~ 1 1.6
# particle minecraft:electric_spark ~ ~1 ~ 0.3 0.3 0.3 0.18 26
# particle minecraft:crit           ~ ~1 ~ 0.4 0.4 0.4 0.20 16

```

## `imperium/function/kits/rastus/strike_cue.mcfunction`

### lines 6–9

Alternative AV cue for a landed Strike (trident thunder + spark/crit particles).

```mcfunction
# playsound minecraft:item.trident.thunder player @s ~ ~ ~ 0.8 1.3
# particle minecraft:electric_spark ~ ~1 ~0.6 0.4 0.4 0.4 0.25 24
# particle minecraft:crit            ~ ~1 ~0.6 0.4 0.4 0.4 0.30 14

```

## `imperium/function/kits/smokey/givekit.mcfunction`

### lines 116–122

Recoil Rod, inline. Superseded by loot_table/smokey/fishing_rod via cd1_rod.

```mcfunction
#item replace entity @s weapon.offhand with \
#    fishing_rod[\
#        max_damage=10,\
#        enchantments={"imperium:wip_grappling":1},\
#        custom_name={text:"Grappling Rod",color:gold,italic:false},\
#        custom_data={"imperium_kit":1b},\
#    ]
```

### lines 126–132

Marking Dart, inline. Superseded by loot_table/smokey/arrow via cd2_arrow.

```mcfunction
#item replace entity @s hotbar.2 with \
#    arrow[\
#        consumable={consume_seconds:0.05,has_consume_particles:false,animation:"trident"},\
#        enchantments={"imperium:single_use":1},\
#        custom_name={text:"Marking Dart",color:gold,italic:false},\
#        custom_data={"imperium_kit":1b},\
#    ]
```

### lines 136–144

Smoke Bomb, inline. Superseded by loot_table/smokey/potion via cd3_potion.

```mcfunction
#item replace entity @s hotbar.3 with \
#    lingering_potion[\
#        potion_contents={\
#            custom_effects:[\
#                {id:"invisibility",amplifier:0,duration:20},\
#                {id:"speed",amplifier:1,duration:20}]},\
#        custom_name={text:"Smoke Bomb",color:gold,italic:false},\
#        custom_data={"imperium_kit":1b},\
#    ]
```

### lines 149–158

Rabbit Stew healing item, inline. Superseded by loot_table/smokey/healing.

```mcfunction
#give @s \
#    rabbit_stew[\
#        food={nutrition:0,saturation:0,can_always_eat:true},\
#        consumable={\
#            consume_seconds:0,\
#            on_consume_effects:[{type:"apply_effects",effects:[\
#                {id:"instant_health",amplifier:0,duration:3}]}]},\
#            use_remainder={"id":"bowl",count:1},\
#        custom_data={"imperium_healing":1b}\
#    ] 10
```

## `imperium/function/main.mcfunction`

### lines 10–13

im_onKill declaration for the retired onKill/killDamage/killFlag mechanic, replaced by the im_combatId / kill_feed flow. Its only score-zeroers already live in this archive; restore both together if that flow is ever revived.

```mcfunction
# onKill/killDamage/killFlag mechanic retired — replaced by the im_combatId/kill_feed flow.
# No live writers or readers; the only score-zeroers live in zz_archive (not loaded). Re-enable
# this declaration if that flow is ever restored from the archive.
# scoreboard objectives add im_onKill dummy
```

### lines 100–100

Below-name HP display. Kept off deliberately - no global scoreboard displays are allowed in the booth.

```mcfunction
    # scoreboard objectives setdisplay below_name im.hp
```

## `imperium/function/main/game_triggers.mcfunction`

### lines 1–9

Old "game triggers" stat objectives (im_killDamage, im_killFlag, im_HP, im_hunger, im_onDeath, im_onJoin, im_onLeave). Superseded by main/init_stats and main/init_cooldowns.

```mcfunction
# Game triggers (old)
    # scoreboard objectives add im_killDamage custom:damage_dealt
    # scoreboard objectives add im_killFlag playerKillCount
    # scoreboard objectives add im_HP health
    # scoreboard objectives add im_hunger food
    # scoreboard objectives add im_onDeath deathCount
    # scoreboard objectives add im_onJoin custom:play_time
    # scoreboard objectives add im_onLeave custom:leave_game
    
```
