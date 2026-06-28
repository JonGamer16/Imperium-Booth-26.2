# Centralized ability tuning knobs — set on load (called from main), like main/init_cooldowns.
# Keep gameplay numbers here instead of scattering them through the ability functions.


# Livvy
    # Lifesteal: damage score (1/10 HP) needed for 1 soup; excludes damage taken.
    scoreboard players set #lsThreshold im_lifesteal 160

    # Venom DoT (imperium:venom, kits/livvy/venom_apply + venom_tick):
    #   Duration = total tag lifetime (ticks); Interval = ticks between damage hits.
    #   (Damage-per-hit stays a literal in venom_tick — the /damage command needs a literal.)
    scoreboard players set #VenomDuration im.param 60
    scoreboard players set #VenomInterval im.param 10

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