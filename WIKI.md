# Imperium Mundi — Project Wiki

> Vanilla-replica Kit PvP datapack (Ver 26.2, pack_format 101) for the Smithed Summit / Baobab
> Battlegrounds booth. This wiki maps **where every file sits, what calls what, and when**, plus
> flags legacy code to strip and per-tick hotspots to watch.
>
> Built by reading the tree as of `main` @ `295ebac`. When you change the call graph, update the
> [Runtime flow](#3-runtime-flow--what-calls-what-when) and [Strip-down candidates](#7-strip-down-candidates-legacy--dead-code) sections.

---

## Table of contents
1. [System at a glance](#1-system-at-a-glance)
2. [Top-level file map](#2-top-level-file-map)
3. [Runtime flow — what calls what, when](#3-runtime-flow--what-calls-what-when)
   - [Load sequence](#31-load-sequence-on-datapack-load)
   - [Per-tick loop](#32-per-tick-loop)
   - [Booth: enter & kit-stand click](#33-booth-enter--kit-stand-click)
   - [Kit selection → givekit pipeline](#34-kit-selection--givekit-pipeline)
   - [Ability cooldown engine](#35-ability-cooldown-engine-the-heart-of-the-current-system)
   - [Combat: damage, kill, death](#36-combat-damage-kill-death)
   - [Enchantments](#37-enchantments-trigger-model)
4. [Subsystem reference](#4-subsystem-reference)
5. [Per-kit map](#5-per-kit-map)
6. [What's relevant for the KitPvP](#6-whats-relevant-for-the-kitpvp)
7. [Strip-down candidates (legacy / dead code)](#7-strip-down-candidates-legacy--dead-code)
8. [Performance hotspots](#8-performance-hotspots)
9. [Known gaps & booth-integration TODO](#9-known-gaps--booth-integration-todo)

---

## 1. System at a glance

There are **two combat systems in the repo at once** — a legacy one being retired and the current one:

| | Legacy (being removed) | **Current (keep / extend)** |
|---|---|---|
| Item refill | `itemreload` score + `arena/item_distributor_300` | **`im_abilityCd*` cooldown engine** (`update_cooldowns` → `kit_dispatch`) |
| Item defs | `function/items/*` (arrow, trident, totem…) | **`function/kits/<kit>/*`** (per-kit, self-contained) |
| Heals | `function/healing_items/*` + `r*` scores | **per-kit `loot give … healing` loot tables** |
| Roster | flat global scores, teams (zombie/blaze) | **`im.kit_<name>` tag per player** |

The current design: **one tag per kit** (`im.kit_cliffshield`, …) drives everything — ability dispatch,
on-kill heals, booth routing. Each kit is a self-contained folder under `function/kits/`. Gameplay
numbers are centralized in `main/ability_parameters` and `main/init_cooldowns`.

External libraries (vendored, do not edit): **`player_motion`** (knockback/launch math) and
**`player_input`** (WASD/sneak/jump key capture).

---

## 2. Top-level file map

```
! Imperium Booth 26.2/
├── pack.mcmeta                      Pack metadata (format 101)
├── booth_definition/
│   └── booth_definition.json        Summit booth: bounds, ticking_functions, stickers, balloons
├── readme.txt                       Project blurb (ASCII logo + about)
├── todo.txt                         Live task list — kit abilities + booth integration plan
├── old_systems.txt                  "How to add a kit/item" cookbook (LEGACY workflow)
├── doc.txt                          Stub (this wiki supersedes it)
├── WIKI.md                          ← you are here
│
├── .claude/
│   ├── Smithed API/                 Reference docs for Summit/Battlegrounds APIs
│   ├── MinecraftWikiScrape/         Offline wiki dump tooling
│   └── skills/                      minecraft-wiki, smithed-summit-api skills
│
└── data/
    ├── minecraft/tags/function/
    │   ├── load.json                ENTRY: imperium:main + lib loads
    │   └── tick.json                ENTRY (local test): imperium:loop + loop_enchantments
    │
    ├── imperium/                     ← THE DATAPACK
    │   ├── function/                 (detailed below)
    │   ├── enchantment/              Custom enchant defs (active + wip_*)
    │   ├── advancement/              Event triggers → reward functions
    │   │     booth/select_<kit>      right-click stand → kits/<kit>/booth/click
    │   │     combat/cooldown_dealt|taken  damage events → update_cooldowns
    │   │     combat/shot_arrow       crossbow shot → arrow_recount
    │   ├── loot_table/<kit>/         Kit gear, display gear, heal stacks
    │   ├── predicate/                on_ground, sneaking, at_spawn, has_venom, has_bad_omen
    │   ├── recipe/                   craftsoup + diamond weapon recipes
    │   ├── damage_type/              light, venom, shield_pierce
    │   ├── item_modifier/            apply_shield_pierce
    │   ├── dialog/                   kitselect dialog
    │   └── tags/                     block/damage_type/entity_type tags (im.*)
    │
    ├── player_motion/                EXTERNAL LIB — launch/knockback vector math
    └── player_input/                 EXTERNAL LIB — key/movement capture
```

### `imperium/function/` breakdown

```
function/
├── main.mcfunction                  Load entry — declares objectives, calls main/* setup
├── main/
│   ├── constants.mcfunction         Fake-player "const" number table (0,1,2,…,10000)
│   ├── ability_parameters.mcfunction  TUNING: venom/smoke/dodge/strike durations & powers
│   ├── ability_cooldowns.mcfunction   Declares im_abilityCd*/Uses/Max/Stock/Floor, calls init_cooldowns
│   ├── init_cooldowns.mcfunction    TUNING: per-kit/slot cooldown bases, stockpile %, charges
│   ├── enchantments.mcfunction      Declares all enchantment objectives
│   ├── game_triggers.mcfunction     Declares HP/kill/death/join/leave objectives
│   ├── gamerules.mcfunction         (disabled — can't set gamerules in Summit)
│   └── old_objectives.mcfunction    LEGACY objective declarations
│
├── loop.mcfunction                  MAIN TICK — drives combat per-tick + the 5t/1s clocks (see §3.2)
├── loop_5t.mcfunction               5-tick loop — booth UI scaffold (empty; stands are now event-driven)
├── loop_1s.mcfunction               1-second loop (arrow aging/cleanup)
├── loop_enchantments.mcfunction     TICK — brittle/chinks/lifesteal upkeep
├── loop_events.mcfunction           EMPTY stub
│
├── update_cooldowns.mcfunction      Bleeds cooldowns by net damage, dispatches abilities (event-driven)
├── kit_dispatch.mcfunction          Routes expired cooldown → that kit's abilities.mcfunction
│
├── internal/
│   ├── cooldown_dealt.mcfunction    Reward of combat/cooldown_dealt → runs update_cooldowns (attacker)
│   ├── cooldown_taken.mcfunction    Reward of combat/cooldown_taken → runs update_cooldowns (victim)
│   ├── arrow_recount.mcfunction     Reward of combat/shot_arrow → resync slot-B ammo count
│   ├── reset_drought.mcfunction     Reward of attack_player → zero Rastus melee charge
│   └── damage_light.mcfunction      (light damage_type helper)
│
├── kits/<kit>/                      ONE FOLDER PER KIT (see §5)
│   ├── givekit.mcfunction           Equip gear + set cooldown bases + add im.kit_ tag
│   ├── abilities.mcfunction         Dispatch target: which cd slot fires which cd*_ function
│   ├── cd1_*/cd2_*/cd3_*            Per-slot ability effect (also re-arms the slot)
│   ├── healing.mcfunction           Heal refill
│   ├── on_kill.mcfunction           On-kill heal top-up
│   └── booth/
│       ├── summon.mcfunction        Spawn display armor_stand + interaction entity
│       ├── click.mcfunction         Reward of booth/select_<kit> — routes click → select/lore
│       ├── select.mcfunction        Equip kit + print ability list (plain click)
│       └── lore.mcfunction          Print fighter lore (sneak + click)
│
├── booth/                           ⚠ check_stands/handle_click/match_clicker now DEAD (see §7)
│   ├── check_stands.mcfunction      (dead) old per-tick click poll
│   ├── handle_click.mcfunction      (dead) old UUID-exact click router
│   ├── match_clicker.mcfunction     (dead) old UUID identity match helper
│   ├── setup_stands.mcfunction      One-shot: build a test row of all 7 stands
│   ├── enter_booth.mcfunction       on_player_enter: title card
│   └── walltext.txt                 Draft booth wall text
│
├── arena/
│   ├── givekit.mcfunction           KIT ROUTER: givekit score → kit tag + givekit fn
│   ├── lastkit.mcfunction           Re-give last kit (givekit=0 path)
│   ├── death.mcfunction             Reset scores on death (mostly LEGACY resets)
│   ├── kill.mcfunction              On-kill: damage gate → heals + per-kit on_kill
│   ├── kill.mcfunction / arena_teleport / item_distributor_300 / lastkit
│   └── (item_distributor_300 = LEGACY refill)
│
├── abilities/                       Shared ability helpers
│   ├── leap.mcfunction              Shared Leap Feather (Livvy + Meowdy) via player_motion
│   ├── leap_refund.mcfunction       Ground-only leap refund
│   └── set_cd.mcfunction            Macro: set a kit/slot cooldown base+floor
│
├── enchantments/                    Custom-enchant logic (called from enchant defs/advancements)
├── healing_items/                   LEGACY heal item scripts
├── items/                           LEGACY kit-item scripts (arrow, trident, totem…)
├── internal/                        reset_drought, damage_light helpers
├── data_fetching/                   get_rotation, get_hurt_time
├── raycaster/                       Raycast hit-detection (mostly disabled/WIP)
└── util/                            clear_kit, copy_gear, giveheals, giveloot
```

---

## 3. Runtime flow — what calls what, when

### 3.1 Load sequence (on datapack load)

`minecraft:load` tag →

```
imperium:main
├── (declares trigger/dummy objectives inline: givekit, onKill, im.temp, im_booth_uuid,
│    im_markTimer, im_venomTimer, im_parryWindow, im.param, HP/maxhp, raycast, etc.)
├── main/enchantments        declare enchantment objectives
├── main/game_triggers       declare HP/kill/death/join/leave objectives
├── main/constants           build "const" number table  (MUST precede init_cooldowns)
├── main/ability_cooldowns   declare cd objectives → calls main/init_cooldowns (per-kit bases)
├── main/old_objectives      LEGACY objectives
└── main/ability_parameters  set tuning constants (venom/smoke/dodge/strike)
   # (main/gamerules is commented out — gamerules locked in Summit)

player_motion:internal/technical/load    external lib init
player_input:zz_internal/init             external lib init
```

**Order dependency:** `constants` before `ability_cooldowns` (the `set_cd` macro reads the const
table); `ability_parameters` after `old_objectives` (writes to objectives declared there).

### 3.2 Per-tick loop

**Local test world** runs via `minecraft:tick` tag → `imperium:loop` + `imperium:loop_enchantments`.
**In the Summit booth**, `booth_definition.json` instead lists `ticking_functions`
(`imperium:tick`@1t, `imperium:5t`@5t, `imperium:loop_1s`@1s) — but **`imperium:tick` and
`imperium:5t` don't exist yet** (see [§9](#9-known-gaps--booth-integration-todo)).

`imperium:loop` (every tick) does, in order:

```
loop.mcfunction
├── effect give @a[hunger 0-19] saturation        (hunger-proofing)
├── @a[givekit=1.., not left spawn] → arena/givekit
│   # ABILITY ENGINE (update_cooldowns) is NO LONGER here — now advancement-driven (see §3.5)
├── @a[killFlag=1..] → arena/kill                 (see §3.6)
├── @a[onDeath=1..] / @a[onLeave=1..] → arena/death
├── store Health → im_hp  (per player)
│
├── Smokey Smoke Bomb:   @e[area_effect_cloud, color match] → smokey/smoke_init
│                        @e[area_effect_cloud, im.smoke_bomb] → smokey/smoke_apply
├── Smokey Marking Dart: @a if has_bad_omen → smokey/mark_apply ; then smokey/mark_tick
├── Livvy Venom:         @a if has_venom → livvy/venom_apply ; then livvy/venom_tick
├── Rastus Air Dodge:    @a[im.kit_rastus] if on_ground → revoke rastus_air_dodge (re-arm)
├── Rastus Strike&Parry: add im_melee_drought ; tick parryWindow ; arm/strip focus_on/off
├── leave_spawn advancement grant/revoke (spawn-zone bookkeeping)
├── enable givekit trigger for spawn players
├── 5-tick clock: #t5 im_5tTimer → at 5 ticks run imperium:loop_5t, reset
└── 1-second clock: #sec im_secTimer → at 20 ticks run loop_1s, reset
```

`imperium:loop_5t` (every 5 ticks — local clock above, or `ticking_functions` in the booth): the
kit & booth interface. **Now empty** — kit-stand selection moved to advancement-driven (see §3.3).
Kept as scaffold for future low-frequency booth UI (dummy reset, vendor cooldown).

`imperium:loop_enchantments` (every tick): Brittle net-damage reset, fishing-bobber Barbs check,
Chinks Curse apply/remove, Livvy Lifesteal banking → soup.

`imperium:loop_1s` (every 20 ticks / 1s): age `@e[arrows]`, kill no-gravity arrows past flight time
(Levent Straight Flight cleanup).

### 3.3 Booth: enter & kit-stand click

**Advancement-driven** (no polling, no UUID matching). Right-clicking a stand fires the per-kit
advancement, whose reward runs *as the exact clicker*:

```
Player enters booth bounds (Summit) → on_player_enter → booth/enter_booth   (title card)

Right-click a kit stand (interaction entity tagged im.booth_<kit>):
  → minecraft:player_interacted_with_entity fires
  → advancement imperium:booth/select_<kit>   (entity condition: nbt {Tags:["im.booth_<kit>"]})
  → reward kits/<kit>/booth/click   (runs AS the clicker)
       advancement revoke @s only imperium:booth/select_<kit>   (re-arm for next click)
       sneak  → kits/<kit>/booth/lore
       plain  → kits/<kit>/booth/select
```

Why this is clean: the advancement reward already runs as the clicking player, so it needs neither
the 5-tick `@e` poll nor the UUID identity match. **`booth/check_stands`, `booth/handle_click`, and
`booth/match_clicker` are now dead** (no caller) — kept for reference / local fallback; safe to
delete. The `im_booth_uuid` objective (declared in `main`) is likewise now unused.

### 3.4 Kit selection → givekit pipeline

```
kits/<kit>/booth/select
├── scoreboard players set @s givekit <N>      (N = the kit's number)
├── function arena/givekit
│     ├── set knockback_resistance / attack_knockback base attrs
│     ├── remove ALL im.kit_* tags
│     ├── init im_abilityCd{A,B,C}=100  (so dispatch waits for damage)
│     ├── givekit==N → add im.kit_<kit> + function kits/<kit>/givekit
│     │     kits/<kit>/givekit:
│     │       ├── util/clear_kit            (wipe old kit items + cd state + rastus attrs)
│     │       ├── item replace … armor/weapons   (the real combat gear)
│     │       ├── function cd1_*/cd2_*/cd3_*      (give ability items, arm slots)
│     │       ├── loot give … <kit>/healing       (heal stack)
│     │       ├── set im_abilityCd{A,B,C} = #<Kit> base
│     │       └── tag @s add im.kit_<kit>
│     ├── im_lastKit = givekit ; reset givekit
│     └── givekit==0 & lastKit>0 → arena/lastkit (re-give last kit)
├── tellraw ability list
└── pling + actionbar confirmation
```

`givekit` number table (from `arena/givekit`): 1 Cliffshield · 2 Meowdy · 3 Livvy · 4 Mummy ·
5 Levent · 6 Rastus · 7 Smokey. (0 = "give my last kit".)

### 3.5 Ability cooldown engine (the heart of the current system)

This **replaces** the legacy `itemreload`/`item_distributor_300` refill. **Advancement-driven** —
runs only on a damage event (the only thing that moves a cooldown), as the player involved:

```
minecraft:player_hurt_entity  → imperium:combat/cooldown_dealt → internal/cooldown_dealt ┐
minecraft:entity_hurt_player  → imperium:combat/cooldown_taken → internal/cooldown_taken ┤
   (each reward: revoke self to re-arm; if leave_spawn=true → update_cooldowns)          │
                                                                                          ▼
update_cooldowns   (reads im_cdUsesB; no longer recounts it here)
├── BLEED: im_abilityCd{A,B,C} -= im_abilityDealt (custom:damage_dealt)
│                              -= im_abilityTaken (custom:damage_taken)
├── clamp charges (im_cdUses*) >= 0
├── SOFT FREEZE: a full slot (uses>=max) can only pre-drain to its floor (banks residual)
├── reset im_abilityDealt / im_abilityTaken = 0
└── any im_abilityCd* <= 0  → kit_dispatch
       kit_dispatch:
         if im.kit_<kit> → kits/<kit>/abilities
           abilities: if cdA<=0 → cd1_*  | cdB<=0 → cd2_*  | cdC<=0 → cd3_*
             cd*_ : apply effect / give item AND re-set its own im_abilityCd* (re-arm)
```

Key idea: **damage dealt and taken charge your abilities.** Charges (`im_cdMax*`) let a slot bank
multiple uses; stockpile % (`im_cdStock*` → `im_cdFloor*`) lets a full slot pre-charge partway.
Tuning lives entirely in `main/init_cooldowns` (bases/charges) and `main/ability_parameters`
(durations/powers). The `set_cd` macro writes base + derived floor.

**Count-based arrow slots (slot B):** `im_cdUsesB` tracks real ammo and is kept in sync purely by
events — `internal/arrow_recount` (on `minecraft:shot_crossbow`, gated `im_cdMaxB>=1`), the refill
(`cd2_arrows` recounts after giving an arrow), and `givekit` (seeds `uses = max`). Reusable for any
crossbow kit whose arrows carry `custom_data {imperium_kit:1b}` — Meowdy today, Cliffshield next.

> **Gate caveat:** the rewards run `update_cooldowns` only `if leave_spawn=true`. `leave_spawn`
> uses an `impossible` trigger (grant-only), and its grant lines are currently **commented out** in
> `loop`. So until you re-enable that grant (or wire it to booth/battlegrounds entry), the engine
> won't fire — same as the old per-tick line it replaced. To test locally, uncomment the
> `leave_spawn` grant in `loop`, or temporarily drop the gate in the two reward functions.

### 3.6 Combat: damage, kill, death

```
On dealing a hit → advancement imperium:attack_player → reward internal/reset_drought
                    (zeroes Rastus's im_melee_drought charge)

Per tick in loop:
  @a[killFlag=1..] → arena/kill
    ├── killDamage>=200 (20 HP) → onKill=1 ; else clear killFlag (no reward)
    ├── LEGACY global refills: items/trident, items/goldarmor, healing_items/*
    ├── @e[onKill=1, im.kit_<kit>] → kits/<kit>/on_kill   (CURRENT: per-kit heal top-up)
    └── reset killDamage/killFlag/onKill

  @a[onDeath=1..] OR @a[onLeave=1..] → arena/death
    └── reset r* heal/item scores, itemreload, teams, onDeath, damage records  (mostly LEGACY)
```

### 3.7 Enchantments (trigger model)

Custom enchantments in `enchantment/*.json` fire logic two ways:
- **Enchantment effect components** — `damage` (conditional multipliers gated on a score, e.g.
  Backstab `im_backstabflag`) and `tick`/post-attack `run_function` into `enchantments/*`.
- **Advancements** in `advancement/` (e.g. `enchantments/combat_hit`, `barbs_hook`,
  `reversal_block`) whose reward functions run the matching `enchantments/*` logic.

Multi-tick enchantments keep their bookkeeping in `loop_enchantments` (Brittle armor net-damage,
Chinks Curse, Livvy Lifesteal banking). `wip_*` enchantments are unfinished — see strip list.

---

## 4. Subsystem reference

| Subsystem | Folder / files | Status | Notes |
|---|---|---|---|
| **Ability cooldown engine** | `update_cooldowns`, `kit_dispatch`, `main/{ability_cooldowns,init_cooldowns,ability_parameters}`, `abilities/set_cd` | **Current** | Core of the kit system. |
| **Kits** | `kits/<kit>/` | **Current** | Self-contained; tag-driven. See §5. |
| **Booth** | `booth/`, `booth_definition.json`, `kits/<kit>/booth/` | **Current/WIP** | Two click routers; Summit wiring pending. |
| **Arena** | `arena/{givekit,lastkit,kill,death}` | Mixed | givekit/kill/death current core; lots of legacy resets inside. |
| **Enchantments** | `enchantment/`, `enchantments/`, `loop_enchantments`, related `advancement/` | Mixed | Active set + `wip_*`. |
| **Shared abilities** | `abilities/{leap,leap_refund,set_cd}` | Current | Leap shared by Livvy + Meowdy. |
| **Predicates** | `predicate/` | Current | `on_ground`, `sneaking`, `at_spawn`, `has_venom`, `has_bad_omen`. |
| **Raycaster** | `raycaster/` | WIP/disabled | `start_raycast` currently just `say` debug. |
| **Data fetching** | `data_fetching/{get_rotation,get_hurt_time}` | Helper/WIP | Referenced by commented loop lines. |
| **Legacy items** | `items/` | **Legacy** | Pre-kit item scripts. |
| **Legacy heals** | `healing_items/` | **Legacy** | Replaced by per-kit heal loot tables. |
| **player_motion** | `data/player_motion/` | External lib | Launch/knockback math. Don't edit. |
| **player_input** | `data/player_input/` | External lib | Key/WASD capture. Don't edit. |

---

## 5. Per-kit map

All seven kits follow the same folder pattern (`givekit`, `abilities`, `cd*_*`, `healing`,
`on_kill`, `booth/{summon,select,lore}`). Tag: `im.kit_<name>`. Cooldown bases in
`main/init_cooldowns`.

| Kit | # | Slot A | Slot B | Slot C | Special tick logic |
|---|---|---|---|---|---|
| **Cliffshield** | 1 | Shield | Arrows | Rush Potion | — |
| **Meowdy** | 2 | Leap (shared) | Arrows (count-based, stock 90) | — | arrow count → `im_cdUsesB` |
| **Livvy** | 3 | Leap (shared) | Web | Acid Potion | Venom DoT, Lifesteal→soup |
| **Mummy** | 4 | Golem Throw | Grapple Rod | — | — |
| **Levent** | 5 | Levitation Arrows | Shield | Reversal | Straight-flight arrow cleanup |
| **Rastus** | 6 | Buckler Shield | Parry | — | Air Dodge, Strike & Parry (Focus), advancement-driven |
| **Smokey** | 7 | Boost Rod | Marking Dart | Smoke Bomb | Smoke cloud apply, Mark DoT/timer |

**Most complex kits** (most moving parts → most to test / most to break): **Rastus** (advancement-
driven air dodge + Strike/Parry attribute juggling, lots of `clear_kit` cleanup) and **Smokey**
(area-effect-cloud + Bad Omen → tag conversion). **Livvy** (Venom + Lifesteal banking) is third.

---

## 6. What's relevant for the KitPvP

The minimum set that actually drives a match (everything else is booth chrome or legacy):

**Must-keep core:**
- `load.json` / `tick.json` → `main` + `loop` + `loop_enchantments`
- `loop.mcfunction` (per-tick orchestrator)
- `update_cooldowns` + `kit_dispatch` (ability engine)
- `main/{constants,ability_cooldowns,init_cooldowns,ability_parameters,enchantments,game_triggers}`
- `arena/{givekit,lastkit,kill}` (kit assign + on-kill heals)
- `kits/<kit>/{givekit,abilities,cd*_*,on_kill,healing}` for all 7 kits
- `abilities/{leap,set_cd}`
- predicates `on_ground`, `sneaking`, `has_venom`, `has_bad_omen`
- active `enchantment/*` + `enchantments/*` + their advancements
- `util/clear_kit`
- `player_motion`, `player_input` libs

**Booth-only (ticks only while a player is in booth bounds):**
- `booth/*`, `kits/<kit>/booth/*`, `booth_definition.json`

**Tuning surface** (where to balance, no logic edits): `main/init_cooldowns` (cooldown lengths +
charges), `main/ability_parameters` (durations/powers), each `cd*_*` (the effect itself), each
kit's `loot_table/<kit>/*` (gear stats).

---

## 7. Strip-down candidates (legacy / dead code)

The repo is mid-migration. These are safe to remove **after confirming the current system covers
their kit/item** (and stripping their resets from `arena/death`):

**Whole legacy subsystems:**
- `function/items/*` — old per-item scripts (arrow, blazepowder, boat, customlingertest,
  damagepot, enderpearl, goldarmor, gravityarrow, jumppot, lightrapier, manualarmor, poisonarrow,
  sapling, shield, slowpot, totem, trident, trident2, windcharge, throwing_knife*). Superseded by
  `kits/<kit>/`.
- `function/healing_items/*` — old heal scripts. Superseded by per-kit `loot_table/<kit>/healing`.
- `arena/item_distributor_300.mcfunction` + the `itemreload`/`rTotem` calls (already commented out
  in `loop`). Superseded by the cooldown engine.
- `main/old_objectives.mcfunction` and the bulk of `arena/death.mcfunction` resets (`r*` heal/item
  scores, `itemreload`, zombie/blaze teams, summon-egg scores).
- `old_systems.txt` documents the **legacy** add-a-kit workflow — outdated vs the current
  tag/folder pattern.

**Newly dead (after the advancement-driven conversion):**
- `booth/check_stands.mcfunction`, `booth/handle_click.mcfunction`, `booth/match_clicker.mcfunction`
  — kit-stand clicks are now `imperium:booth/select_<kit>` → `kits/<kit>/booth/click`. No callers
  left; keep one as a local fallback or delete. The `im_booth_uuid` objective (in `main`) is unused.

**Empty / placeholder / debug:**
- `loop_events.mcfunction` (empty stub)
- `function/test.mcfunction`
- `raycaster/*` — `start_raycast` is a `say` debug stub; raycast path commented out.
- `booth/walltext.txt`, `doc.txt` (stubs; `doc.txt` now superseded by this wiki).
- `data_fetching/*` — only referenced by commented-out loop lines.

**WIP (decide: finish or cut):**
- `enchantment/wip_*` (air_dodge, barrier, focus_attack, golem_throw, grappling, hp_drain,
  lifesteal, marked, rapid, reeling, reversal, straight_flight) and `enchantments/wip_reversal`,
  `enchantments/hp_drain`. Some back unfinished kit abilities (Mummy Golem Throw/Barrier/Grapple,
  Levent Reversal) — see `todo.txt`.

> ⚠️ Before deleting, grep for the name — several legacy items are still *called* from
> `arena/kill` (`items/trident`, `items/goldarmor`, `healing_items/*`) even though they look dead.
> Remove the call site in `arena/kill` / `arena/death` in the same change.

---

## 8. Performance hotspots

Cost in a datapack ≈ per-tick entity selectors and function fan-out. Watch list, by tick cost:

| Where | Cost | Notes / mitigation |
|---|---|---|
| ~~`loop` → `booth/check_stands`~~ | ~~~15 `@e[interaction]` scans every tick~~ | ✅ **DONE** — kit stands now advancement-driven (§3.3); poll removed entirely. |
| ~~`loop` → `update_cooldowns` per `@a`~~ | ~~runs for every in-arena player every tick~~ | ✅ **DONE** — advancement-driven (§3.5); runs only on damage events. Arrow recount also moved off-tick to `internal/arrow_recount`. |
| `loop_enchantments` every tick | `@a` Brittle resets, `@e[fishing_bobber]` scan, `@a` Chinks, `@a[im.kit_livvy]` Lifesteal ops | Most ops are tag-gated; Brittle resets hit **all** `@a` unconditionally. |
| `loop` Smokey block | `@e[area_effect_cloud …]` scans twice/tick | Only matters when smoke clouds exist; fine. |
| `loop` Mark/Venom | `@a if predicate` twice/tick + tick fns | Predicate over all players each tick. |
| `loop` Rastus block | several `@a[tag=im.kit_rastus]` ops/tick | Tag-gated; cheap unless many Rastus players. |
| `loop` `effect give @a[hunger…]` | `@a` scan every tick | Trivial but unconditional. |

**General levers:** (1) get booth ticking off `minecraft:tick`, (2) keep every per-tick selector
tag-gated (`im.kit_*`) so idle kits cost nothing, (3) the planned booth/battlegrounds tick split
(`todo.txt`) is the biggest win — combat logic should only tick for `summit.battlegrounds.player`
during active matches.

---

## 9. Known gaps & booth-integration TODO

(Condensed from `todo.txt` "Booth Integration" — the live source of truth.)

- **Missing ticking targets:** `booth_definition.json` references `imperium:tick` (1t) and
  `imperium:5t` (5t). ✅ **`imperium:5t` now exists** (kit & booth interface). `imperium:tick`
  (the per-tick combat target for Summit) **still doesn't exist** — today only the `minecraft:tick`
  tag drives the combat loop, which works locally but **won't tick inside the Summit booth**.
- **Loop split:** booth interface (`check_stands`) is now off the combat tick (in `imperium:5t`).
  Remaining: create `imperium:tick` for combat and gate it on `summit.battlegrounds.player`.
- **on_player_enter namespace:** `booth_definition` uses `"booth/enter_booth"` — should be
  `"imperium:booth/enter_booth"`.
- **Reset hook:** add a `#summit:api/reset_player` function undoing `clear_kit` + the knockback/
  attack attribute changes from `arena/givekit`.
- **Summit Interactions API:** kit stands should be summoned with `summit.interactable` /
  `summit.static` tags + `on_right_click` data; keep `handle_click` (UUID router) for local only.
- **Battlegrounds registration / match hooks / kit carry-in** — all unstarted (see `todo.txt`).
- **Combat ticking during matches** — open decision: persistent tick vs self-scheduled clock.

---

*Generated from a read-through of the project on 2026-06-24. Diagrams reflect call graphs in
`loop`, `update_cooldowns`, `kit_dispatch`, `arena/*`, and `booth/*` at that time — re-verify after
the booth/battlegrounds tick split lands.*
