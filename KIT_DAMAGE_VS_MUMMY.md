# Kit Damage vs. Warforged Mummy — Balance Chart

Every number below is **damage actually landed on a Mummy**, i.e. raw weapon damage run through
Mummy's armor + toughness + Protection. Values are derived from the live `givekit.mcfunction` /
enchantment JSON in this pack (26.2), not from the tooltip comments (several of those are stale).

---

## 0. Quick reference — raw damage → net damage on Mummy

Lookup table for tuning any new weapon without re-deriving the formula. Armor 15 / toughness 8 /
Protection 8. Interpolate linearly between rows; the curve is smooth in this range.

| Raw | Net | Cut | | Raw | Net | Cut |
|---|---|---|---|---|---|---|
| 0.5 | 0.14 | 72.5% | | 10.5 | 3.61 | 65.7% |
| 1.0 | 0.28 | 72.1% | | 11.0 | 3.81 | 65.3% |
| 1.5 | 0.42 | 71.8% | | 11.5 | 4.03 | 65.0% |
| 2.0 | 0.57 | 71.4% | | 12.0 | 4.24 | 64.6% |
| 2.5 | 0.72 | 71.1% | | 12.5 | 4.46 | 64.3% |
| 3.0 | 0.88 | 70.8% | | 13.0 | 4.69 | 64.0% |
| 3.5 | 1.04 | 70.4% | | 13.5 | 4.91 | 63.6% |
| 4.0 | 1.20 | 70.1% | | 14.0 | 5.14 | 63.3% |
| 4.5 | 1.36 | 69.7% | | 14.5 | 5.37 | 62.9% |
| 5.0 | 1.53 | 69.4% | | 15.0 | 5.61 | 62.6% |
| 5.5 | 1.70 | 69.1% | | 15.5 | 5.85 | 62.3% |
| 6.0 | 1.88 | 68.7% | | 16.0 | 6.09 | 61.9% |
| 6.5 | 2.06 | 68.4% | | 16.5 | 6.34 | 61.6% |
| 7.0 | 2.24 | 68.0% | | 17.0 | 6.59 | 61.2% |
| 7.5 | 2.42 | 67.7% | | 17.5 | 6.84 | 60.9% |
| 8.0 | 2.61 | 67.4% | | 18.0 | 7.10 | 60.6% |
| 8.5 | 2.80 | 67.0% | | 18.5 | 7.36 | 60.2% |
| 9.0 | 3.00 | 66.7% | | 19.0 | 7.62 | 59.9% |
| 9.5 | 3.20 | 66.3% | | 19.5 | 7.89 | 59.5% |
| 10.0 | 3.40 | 66.0% | | 20.0 | 8.16 | 59.2% |

Rules of thumb: **net ≈ raw × 0.30** at low raw, drifting to **× 0.41** by raw 20. Doubling raw
damage slightly more than doubles net damage — every point of raw is worth more than the last, so
Mummy is beaten by big hits, not fast ones.

---

## 1. The defender: Warforged Mummy

Only the helmet carries attribute modifiers — chest/legs/feet are all `!attribute_modifiers`.

| Stat | Value | Source |
|---|---|---|
| Armor | **15** | `mummy/givekit.mcfunction` head modifier |
| Armor toughness | **8** | head modifier |
| Protection | **8 levels** (32% flat) | `enchantments={"protection":8}` on head |
| Base HP | 20 (10 hearts) | vanilla |
| Barrier (situational) | up to **+20 absorption HP** while sneaking | `imperium:barrier` + `#MummyBarrierScale 20` |

The Barrier is a separate absorption pool, not damage reduction — it does not change any number in
this document, it just adds up to 20 HP on top of the 20 HP the tables assume.

### Mitigation formula used

```
reduction  = min(20, max(armor/5, armor - (4 × raw) / (min(toughness,20) + 8))) / 25
afterArmor = raw × (1 − reduction)
final      = afterArmor × (1 − 0.04 × protectionLevels)
```

With armor 15 / toughness 8 / Protection 8 this collapses to:

```
final = raw × (1 − (15 − raw/4)/25) × 0.68
```

Note the toughness term: reduction *falls* as the hit gets bigger, so Mummy punishes chip damage
much harder than burst. See §0 for the raw→net lookup table. Two off-grid values used later in this
document: **7.32 raw → 2.36 net** (Livvy's crit) and **12.81 raw → 4.60 net** (her crit + Strength).

---

## 2. Assumptions

- **Full attack charge.** Every melee number assumes the attack-strength indicator is full
  (×1.0 multiplier). Levent's Light Rod and Rastus's Rapier have `minimum_attack_charge=1`, so they
  are *always* full-charge by construction.
- **Attack damage = 1 (player base) + the item's `base_attack_damage` modifier.** That is how the
  vanilla replacement modifier works, so e.g. Cliffshield's `amount:5` is a 6-damage sword.
- **Attack speed = 4 (player base) + the item's `base_attack_speed` modifier.**
- **Invulnerability frames.** Vanilla gives a target 10 ticks (0.5 s) of invulnerability per hit, so
  anything swinging faster than 2.0/s cannot land every swing. **Exception:** `imperium:light` and
  `imperium:venom` are in `minecraft:bypasses_cooldown`, so the Light Rod and the Lightning Rapier
  land *every* swing.
- **Crit ordering.** Vanilla's ×1.5 crit multiplies the base attribute damage; enchantment `damage`
  effects (`imperium:crits`, `imperium:marked`, `imperium:golem_throw`) are computed off the
  *un-critted* base and added afterward. See §9 if you want the alternate reading.
- Sweeping Edge, knockback, reach and shield-disable are ignored — single-target damage only.

**DPS column** = final damage ÷ effective interval, where interval = `max(1/attackSpeed, 0.5 s)`,
or `1/attackSpeed` for cooldown-bypassing damage types. Rows whose interval exceeds 1 second are
marked ✗ per your ≤1 s rule.

---

## 3. Jeru Cliffshield

| Attack | Raw | Final vs Mummy | Rate | Interval | DPS ≤1 s |
|---|---|---|---|---|---|
| Steel Broadsword | 6.00 | **1.88** | 1.6/s | 0.625 s | **3.00** |
| Silver Glaive (melee) | 8.00 | **2.61** | 1.0/s | 1.000 s | **2.61** |
| Heavy Crossbow — min roll | 8.00 | **2.61** | 0.8/s | 1.25 s | 2.09 ✗ |
| Heavy Crossbow — avg roll | 10.00 | **3.40** | 0.8/s | 1.25 s | 2.72 ✗ |
| Heavy Crossbow — max roll | 12.00 | **4.24** | 0.8/s | 1.25 s | 3.39 ✗ |

- Crossbow arrows roll **7–11** raw in vanilla; `imperium:crossbow_power` I adds a flat **+1** →
  **8–12**. No Quick Charge, so the 1.25 s reload puts it outside the ≤1 s window.
- The Glaive's `kinetic_weapon` charge (right-click) is **not** in the table: its damage is
  `floor(relativeSpeed × 0.8)`, i.e. purely a function of closing speed, plus a 4-tick arm delay.
  At a typical sprint closing speed of ~0.3 b/t relative it floors to 0 — it is a knockback/pin
  tool against Mummy, not a damage tool.
- `!piercing_weapon` is stripped from the spear, so the Glaive is an ordinary single-target melee
  weapon, not a jab attack.

## 4. Quin Meowdy

| Attack | Raw | Final vs Mummy | Rate | Interval | DPS ≤1 s |
|---|---|---|---|---|---|
| Shortsword | 6.00 | **1.88** | 2.0/s | 0.500 s | **3.75** |
| Cat Claw | 4.00 | **1.20** | 10.0/s → 2.0/s | 0.500 s | **2.39** |
| Quickdraw Crossbow — min | 7.00 | **2.24** | 2.0/s | 0.500 s | **4.47** |
| Quickdraw Crossbow — avg | 9.00 | **3.00** | 2.0/s | 0.500 s | **6.00** |
| Quickdraw Crossbow — max | 11.00 | **3.81** | 2.0/s | 0.500 s | **7.63** |
| Birdshot Crossbow — avg | 9.00 | **3.00** | 0.8/s | 1.25 s | 2.40 ✗ |

- **Cat Claw is entirely wasted speed.** 10 attacks/s against a 0.5 s i-frame window means 8 of
  every 10 swings do nothing, and the 2 that land are the pack's weakest hit. It is strictly worse
  than the Shortsword against Mummy (2.39 vs 3.75 DPS).
- **The Quickdraw crossbow is Meowdy's best weapon against Mummy by a wide margin** — Quick Charge
  III gives a 0.5 s reload, so at 6.00 DPS average it beats the Shortsword by 60%.
- Birdshot's Multishot fires 3 arrows, but all three arrive inside the same 0.5 s i-frame window,
  so at point-blank only the first one's damage effectively counts. Treat it as a spread tool.

## 5. Livvy the Vampire Spider

Fang base = 4.00 raw (`amount:3`), 2.0 attacks/s. `imperium:crits` II = ×1.33 on the base,
conditioned on exactly the vanilla crit conditions (airborne, falling, not sprinting).
Strength I from her Leap is a flat **+3** attack damage for 1 second.

| Attack | Raw | Final vs Mummy | Rate | Interval | DPS ≤1 s |
|---|---|---|---|---|---|
| Neutral | 4.00 | **1.20** | 2.0/s | 0.500 s | **2.39** |
| Critical (vanilla ×1.5 + Crits II) | 7.32 | **2.36** | 2.0/s | 0.500 s | **4.71** |
| With Strength I | 7.00 | **2.24** | 2.0/s | 0.500 s | **4.47** |
| Critical + Strength I *(bonus row)* | 12.81 | **4.60** | 2.0/s | 0.500 s | **9.20** |

Working for the crit row: base `f = 4`; enchant bonus `f1 = 4×1.33 − 4 = 1.32`; crit applies to the
base only → `4 × 1.5 = 6`; total `6 + 1.32 = 7.32`.

Livvy's neutral hit is tied for the worst sustained damage in the pack against Mummy. Her entire
kit output against this matchup lives on landing crits — and the 1-second Strength window from Leap
lines up with exactly the airborne state that arms the crit, so **Leap → falling crit is her real
damage rotation** (9.20 DPS, ~4× her neutral).

Lifesteal is a heal, not damage, and is excluded.

## 6. Levent the Shulker Knight

Light Rod = 5.00 raw, 3.0 attacks/s, `damage_type="imperium:light"` → **bypasses i-frames**, so all
3 swings/second land. Charge Attack arms after `#LeventCharge = 14` idle ticks and adds **+2**
attack damage to exactly one hit.

| Attack | Raw | Final vs Mummy | Rate | Interval | DPS ≤1 s |
|---|---|---|---|---|---|
| Light Rod, normal | 5.00 | **1.53** | 3.0/s | 0.333 s | **4.59** |
| Light Rod, charged (single hit) | 7.00 | **2.24** | — | — | burst |
| Light Rod, charge-cycled sustained | 7.00 | 2.24 | 1 per 15 t | 0.75 s | **2.98** |
| Aero Shot bow — min (6 raw) | 6.00 | **1.88** | 1.0/s | 1.000 s | **1.88** |
| Aero Shot bow — avg (8.5 raw) | 8.50 | **2.80** | 1.0/s | 1.000 s | **2.80** |
| Aero Shot bow — max (11 raw) | 11.00 | **3.81** | 1.0/s | 1.000 s | **3.81** |

- **Charging is a DPS loss for Levent.** Waiting 14 ticks for +2 raw yields 2.98 DPS; just spamming
  the rod yields 4.59. The charge is worth it only for the reach (+1 block) and knockback (+0.5),
  or to make a single hit count before disengaging. If you want charging to be the correct play,
  the +2 needs to be roughly +5, or `#LeventCharge` needs to drop.
- Bow damage is the vanilla critical-charge roll (**6–11** at a 1 s draw). `imperium:straight_flight`
  only sets `NoGravity` — no damage change, though the flat trajectory keeps impact speed (and
  therefore damage) at the top of the range at long distance.

## 7. Rastus the Duelist

Lightning Rapier = 2.50 raw (`amount:1.5`), 8.0 attacks/s, `piercing_weapon`,
`damage_type="imperium:light"` → **bypasses i-frames**. Strike arms after `#StrikeCharge = 12` idle
ticks and adds **+5** attack damage and +1 attack speed to one hit.

| Attack | Raw | Final vs Mummy | Rate | Interval | DPS ≤1 s |
|---|---|---|---|---|---|
| Normal jab (theoretical 8 CPS) | 2.50 | **0.72** | 8.0/s | 0.125 s | **5.78** |
| Normal jab (realistic 6 CPS) | 2.50 | **0.72** | 6.0/s | 0.167 s | **4.33** |
| Charged Strike (single hit) | 7.50 | **2.42** | — | — | burst |
| Strike-cycled sustained | 7.50 | 2.42 | 1 per 13 t | 0.65 s | **3.73** |

- **0.72 damage per jab is the single lowest hit in the pack** — Mummy's toughness eats 71% of it.
  Rastus's whole case against Mummy rests on i-frame bypass letting him land 6–8 of them per second.
- **Strike-cycling is also a DPS loss** (3.73 vs 4.33–5.78 spamming). Same structural problem as
  Levent: the idle window costs more than the bonus pays. Strike's value here is burst + knockback,
  not sustained damage.
- Piercing means the jab hits every entity along the ray — irrelevant 1v1, relevant if Mummy has a
  golem/summon between you.

## 8. Warforged Mummy (mirror match)

Dark Claymore = 7.00 raw (`amount:6`), 1.2 attacks/s. `imperium:golem_throw` multiplies damage by
**×1.5** while `im_golemReady = 1`. `imperium:mace_smash` sets `smash_damage_per_fallen_block` to
**−2**, which cancels most of the vanilla mace fall scaling.

| Attack | Raw | Final vs Mummy | Rate | Interval | DPS ≤1 s |
|---|---|---|---|---|---|
| Dark Claymore, normal | 7.00 | **2.24** | 1.2/s | 0.833 s | **2.68** |
| Dark Claymore + Golem Throw | 10.50 | **3.61** | 1.2/s | 0.833 s | 4.33 (burst) |

### Mace smash attack (fall damage bonus)

Vanilla smash bonus is `4d` for `d ≤ 3`, `12 + 2(d−3)` for `3 < d ≤ 8`, `22 + (d−8)` beyond.
`imperium:mace_smash` subtracts `2 × d`, giving a bonus that **plateaus at +6 for 3–8 blocks and
then decays back to zero**:

| Fall distance | Smash bonus | Raw total | Final vs Mummy |
|---|---|---|---|
| 1.5 b (minimum) | +3.0 | 10.00 | **3.40** |
| 2 b | +4.0 | 11.00 | **3.81** |
| 3 b | +6.0 | 13.00 | **4.69** |
| 4 b | +6.0 | 13.00 | **4.69** |
| 5 b | +6.0 | 13.00 | **4.69** |
| 6 b | +6.0 | 13.00 | **4.69** |
| 8 b | +6.0 | 13.00 | **4.69** |
| 10 b | +4.0 | 11.00 | **3.81** |
| 12 b | +2.0 | 9.00 | **3.00** |
| 15 b | 0 | 7.00 | **2.24** |

That flat 3–8 block plateau looks intentional and works well; the decay past 8 blocks means a
high-altitude drop is *worse* than a 3-block hop, which players will not expect. Worth a look if
that wasn't deliberate.

Golem Throw and the smash are separate events — Golem Throw launches the victim upward, it does not
stack with your own fall.

## 9. Smokey Bat

Per your request, Smokey's dagger is given as a raw→final lookup rather than modelled through
`imperium:crits` III / `imperium:backstab` / `imperium:marked` stacking. DPS assumes the 2 hits/s
i-frame ceiling.

| Raw | Final vs Mummy | Cut | DPS at 2 hits/s |
|---|---|---|---|
| 3.0 | **0.88** | 70.8% | **1.75** |
| 4.5 | **1.36** | 69.7% | **2.72** |
| 6.0 | **1.88** | 68.7% | **3.75** |
| 9.0 | **3.00** | 66.7% | **6.00** |
| 12.0 | **4.24** | 64.6% | **8.49** |

**Marking Dart:** summoned `minecraft:arrow` with `damage: 2.0f` (vanilla base) at Motion 3.0 b/t,
non-crit → `ceil(3.0 × 2.0) =` **6.00 raw → 1.88 final**. It is a tagging tool, not a damage tool;
its value is the `im.marked` tag that unlocks the ×1.5 Marked multiplier on the dagger and hatchet.

For reference, the Sweeping Hatchet's offhand proc (`imperium:enchantments/offhand_attack`) deals a
flat `damage @s 6 imperium:light` → **1.88 final**, and being `imperium:light` it bypasses i-frames,
so it stacks on top of a mainhand swing in the same tick.

---

## 10. Cross-kit summary vs. Mummy

Best sustainable ≤1 s DPS available to each kit:

| Kit | Best sustained line | DPS | Hits to strip 20 HP |
|---|---|---|---|
| Rastus | Rapier spam @ 8 CPS (i-frame bypass) | **5.78** | 28 |
| Meowdy | Quickdraw crossbow, avg roll | **6.00** | 7 |
| Livvy | Leap → falling crit + Strength | **9.20** | 5 |
| Livvy | crit only (no Strength) | 4.71 | 9 |
| Levent | Light Rod spam (i-frame bypass) | **4.59** | 14 |
| Mummy | Dark Claymore, normal | **2.68** | 9 |
| Cliffshield | Steel Broadsword | **3.00** | 11 |
| Smokey | depends on raw; 6 raw baseline | 3.75 | 11 |

Neutral, no-setup damage only (the honest floor for each kit):

| Kit | Neutral attack | Final | DPS |
|---|---|---|---|
| Cliffshield | Broadsword | 1.88 | 3.00 |
| Meowdy | Shortsword | 1.88 | 3.75 |
| Livvy | Fang | 1.20 | 2.39 |
| Levent | Light Rod | 1.53 | 4.59 |
| Rastus | Rapier | 0.72 | 4.33–5.78 |
| Mummy | Dark Claymore | 2.24 | 2.68 |
| Smokey | (6 raw) | 1.88 | 3.75 |

### Balance observations

1. **Mummy eats 64–71% of everything.** Nothing in the pack lands more than 4.7 damage per hit on
   him outside of Livvy's crit+Strength window and Mummy's own Golem Throw. Combined with the +20
   absorption Barrier, a defensive Mummy is effectively a 40 HP pool that takes 2–4 damage a swing.
   Time-to-kill sits around 5–8 seconds for the best lines and 15–20 s for the worst.
2. **Both "charge" mechanics are net DPS losses.** Levent's Charge Attack (+2 raw for 14 idle ticks)
   and Rastus's Strike (+5 raw for 12 idle ticks) both come out behind simply spamming. They read as
   the kits' signature moves but are mechanically punished. Either bonus needs to roughly double, or
   the idle window needs to shrink, before charging is the correct play.
3. **Cat Claw does nothing.** 10 attacks/s against a 0.5 s i-frame window is 80% wasted input, and it
   is Meowdy's worst option against Mummy by a factor of 1.6. Either give it a cooldown-bypassing
   damage type (like the Light Rod) or accept it as a knockback/aggression tool.
4. **Crossbows outperform melee against a heavy-armor target.** Because reduction shrinks as hits get
   bigger, the 7–11 arrow rolls are unusually efficient here. Meowdy's Quickdraw at 6.00 DPS is the
   second-best sustained line in the pack against Mummy despite Meowdy being the light-armor rushdown
   kit — probably not the intended read.
5. **Livvy is feast-or-famine.** Worst neutral in the pack (2.39 DPS) and the best setup ceiling
   (9.20). Her matchup against Mummy is entirely decided by whether she can keep landing airborne
   crits.
6. **Cliffshield's Glaive is the biggest single ordinary hit** (2.61) but at 1.0 attacks/s his
   Broadsword still out-DPSes it. Nothing wrong with that — it's a reach/poke trade.

---

## 11. Caveats

- **Crit ordering.** These tables assume vanilla's ×1.5 applies to base attribute damage and
  enchantment `damage` effects are added on top from the un-critted base — which is how
  `Player.attack()` sequences it in 1.21+. If 26.2 changed this to apply enchantment multipliers
  after the crit, Livvy's crit becomes **7.98 raw → 2.60 final** (instead of 7.32 → 2.36) and her
  crit+Strength becomes **13.97 raw → 5.13 final**. Everything else is unaffected (no other listed
  attack combines a crit with a `multiply` enchantment).
- The local wiki dump is truncated on the `Melee attack` and `Mace` pages, so the crit-ordering and
  smash-tier formulas above come from the vanilla source behaviour rather than a citable wiki
  section. `Density` confirmed `smash_damage_per_fallen_block` is per-block-fallen damage, and
  `Calculators/Armor protection` confirmed the armor/toughness formula.
- Realistic click rates cap Rastus and the Cat Claw well below their attribute speeds; 6 CPS is
  used as the practical figure for Rastus.
- Arrow rolls are uniform-random over their range; "avg" rows use the midpoint.
