# Centralized ability tuning knobs — set on load (called from main), like main/ability_cooldowns.
# Keep gameplay numbers here instead of scattering them through the ability functions.


# Livvy
    # Lifesteal: damage score (1/10 HP) needed for 1 soup; excludes damage taken.
    scoreboard players set #lsThreshold im_lifesteal 160

    # Venom DoT (imperium:venom, kits/livvy/venom_apply + venom_tick):
    #   Duration = total tag lifetime (ticks); Interval = ticks between damage hits.
    #   (Damage-per-hit stays a literal in venom_tick — the /damage command needs a literal.)
    scoreboard players set #VenomDuration im.param 63
    scoreboard players set #VenomInterval im.param 7

    # Web Throw: how long a thrown web (cobweb block display) lingers before despawning. 20t = 1s.
    scoreboard players set #WebDuration im.param 60

# Smokey — Smoke Bomb: lifetime (ticks) of the artificial smoke cloud (kits/smokey/smoke_init).
    scoreboard players set #SmokeDuration im.param 200

    # Grappling Rod (kits/smokey/grapple_launch): launch toward the bobber, distance-proportional.
    #   Lateral  = horizontal (x,z) pull divisor — lower = stronger.
    scoreboard players set #GrappleLateral im.param 10
    #   VertPull = vertical (y) pull divisor       — lower = stronger.
    scoreboard players set #GrappleVertPull im.param 10
    #   Vertical = static upward impulse added on top (1/10000 blocks/tick, like leap's pop).
    scoreboard players set #GrappleVertical im.param 4000
    #   Max      = speed cap on the pull, per axis (1/10000 b/t); -1 = unlimited. Applied before
    #              the static Vertical pop, so the pop always lands regardless of the cap.
    scoreboard players set #GrappleMax im.param 20000

# Mummy
    #   Grappling Rod (kits/mummy/mgrapple_*): yanks the hooked entity to the Mummy.
        #   Enter Reciprocal strength factor (lower = stronger)
        scoreboard players set #MummyGrappleLateral im.param 10
        scoreboard players set #MummyGrappleVertPull im.param 10
        #   Vertical: should be high enough to lift the target off the ground into an arc.
        scoreboard players set #MummyGrappleVertical im.param 9000
        scoreboard players set #MummyGrappleMax im.param 20000
        #   CastSpeed: integer multiplier on the bobber's launch Motion (faster/farther cast).
        scoreboard players set #MummyCastSpeed im.param 2

    # Energy meter (kits/mummy/energy_*): a 0..#MummyEnergyMax pool shown on the action bar, spent by
        #   Golem Throw / Energy Barrier / Mace Smash and refilled by eating an Energy Crystal.
        scoreboard players set #MummyEnergyMax im.param 100
        #   Energy a Mummy spawns / re-kits with.
        scoreboard players set #MummyEnergyStart im.param 100
        #   Energy gained per Energy Crystal consumed.
        scoreboard players set #MummyEnergyCrystal im.param 100
    #   Crystal Bomb (kits/mummy/crystal_bomb): placing a crystal as a bomb (sneak-consume) refunds
    #   reduced resources vs eating it — this much energy instead of the full #MummyEnergyCrystal, and
    #   only the instant heal (the regen the consumable applies is stripped). See crystal_bomb.
        scoreboard players set #MummyCrystalBombEnergy im.param 50
        #   Crystal Bomb fuse: ticks from placement to detonation (20t = 1s).
        scoreboard players set #BombFuse im.param 20
        #   Crystal Bomb blast: damage = #BombMaxDamage at the center, falling #BombDropoff per block out to
        #   #BombRange blocks (whole damage units, dealt in 1-block rings via execute-as + /damage @s).
        #   imperium:bomb type — no knockback (won't fight the launch); still reduced by the target's armor.
        scoreboard players set #BombMaxDamage im.param 16
        scoreboard players set #BombRange im.param 8
        scoreboard players set #BombDropoff im.param 1
        #   Blast launch: upward impulse on everything the blast hits — INCLUDING the placer (a built-in
        #   self-boost; the placer still takes no damage). In 1/10000 b/t; ~10000 (1.0 b/t) ≈ 5 blocks up.
        scoreboard players set #BombLaunch im.param 10000
    #   Per-ability costs. An ability calls kits/mummy/energy_spend {cost:<n>} and only fires when it
    #   reports success (enough banked). Wire each WIP enchant to read its cost here.
        scoreboard players set #MummyGolemThrowCost im.param 30
        scoreboard players set #MummySmashCost im.param 25
    #   Energy Barrier (kits/mummy/barrier_*): hold sneak to spend energy as absorption hearts; hits
    #   drain the hearts (and the meter), releasing sneak refunds the leftover.
    #   Scale = absorption HP granted per 100 energy (20 -> full 100 energy = 20 HP = 10 hearts).
    #   NOTE: the absorption amplifier in barrier_raise must cover EnergyMax*Scale/100 HP — at amp 4
    #   the cap is (4+1)*4 = 20 HP, which exactly fits the default. Raise the amp if you raise Scale.
        scoreboard players set #MummyBarrierScale im.param 20
        #   Minimum energy required to raise the barrier (no putting up a sliver of a shield).
        scoreboard players set #MummyBarrierMin im.param 10

    # Golem Throw (kits/mummy/golem_*): a charged heavy hit that flings the victim up and deals bonus
    #   damage (the ×1.5 lives in the wip_golem_throw enchant — a literal there, not a score).
        #   ChargeTime = wind-up ticks (while sneaking) before the hit arms (20t = 1s).
        scoreboard players set #GolemChargeTime im.param 30
        #   Window = ticks the armed hit stays usable; miss the window and the charge drops, re-winding for
        #   a fresh cycle. ChargeEnd (derived) = the charge value at which the window closes.
        scoreboard players set #GolemWindow im.param 30
        scoreboard players operation #GolemChargeEnd im.param = #GolemChargeTime im.param
        scoreboard players operation #GolemChargeEnd im.param += #GolemWindow im.param
        #   Launch = upward impulse applied to the victim, in 1/10000 blocks/tick (12000 = 1.2 b/t pop).
        scoreboard players set #GolemLaunch im.param 12000
        #   HookLaunch = upward impulse on the Mummy ITSELF when it Golem-Throws an enemy it's currently
        #   grappling (the "throw + ride the recoil" combo), same 1/10000 b/t units. See golem_hook_recoil.
        scoreboard players set #GolemHookLaunch im.param 12000

# Rastus
    # Air Dodge: Launch power (10000 * blocks/tick)
        scoreboard players set #DodgePower im.param 4000

    # Strike & Parry: shared charge time (idle ticks of not attacking/blocking before
    # both are armed) and the parry's full-deflect window (ticks of Resistance V + KB immunity
    # after a charged shield raise). 20 ticks = 1s.
        scoreboard players set #StrikeCharge im.param 12
        scoreboard players set #ParryWindow im.param 3

# Levent
    # Charge Attack: idle ticks of not attacking OR raising the shield before the next hit gets
    # the boost (bonus damage, reach, knockback). 20 ticks = 1s; the slow Light Rod wants a touch
    # longer wind-up than Rastus's Strike.
    scoreboard players set #LeventCharge im.param 25