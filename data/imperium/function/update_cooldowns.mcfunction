# Count-based charges: the slot-B arrow count (im_cdUsesB) is now kept in sync by events, not a
# per-tick scan here — imperium:internal/arrow_recount on each crossbow shot, the refill itself
# (cd2_arrows), and givekit. This function only reads im_cdUsesB; it never recounts.

# This whole engine is now advancement-driven (imperium:internal/cooldown_dealt + cooldown_taken),
# so it only runs on a tick where the player dealt or took damage — the only events that move a
# cooldown. The "each tick" comments below are historical; read them as "per damage event".

# Bleed every cooldown by net damage each tick.
scoreboard players operation @s im_abilityCdA -= @s im_abilityDealt
scoreboard players operation @s im_abilityCdA -= @s im_abilityTaken
scoreboard players operation @s im_abilityCdB -= @s im_abilityDealt
scoreboard players operation @s im_abilityCdB -= @s im_abilityTaken
scoreboard players operation @s im_abilityCdC -= @s im_abilityDealt
scoreboard players operation @s im_abilityCdC -= @s im_abilityTaken

# Keep charge counts non-negative. Cooldowns are deliberately NOT clamped to 0 here:
# a spent slot may dip below 0, and that overshoot is the residual damage credit the
# refill banks via `+= base`. Frozen slots are still bounded by their floor clamp below.
scoreboard players operation @s im_cdUsesA > const 0
scoreboard players operation @s im_cdUsesB > const 0
scoreboard players operation @s im_cdUsesC > const 0

# Soft freeze: a FULL slot (uses >= max, max > 0) can only pre-drain to its stockpile
# floor, banking residual damage. A non-full slot keeps bleeding so it can refill the
# next charge. Floors are clamped >= 1 in init, so a frozen slot never reaches 0.
execute if score @s im_cdMaxA matches 1.. if score @s im_cdUsesA >= @s im_cdMaxA run scoreboard players operation @s im_abilityCdA > @s im_cdFloorA
execute if score @s im_cdMaxB matches 1.. if score @s im_cdUsesB >= @s im_cdMaxB run scoreboard players operation @s im_abilityCdB > @s im_cdFloorB
execute if score @s im_cdMaxC matches 1.. if score @s im_cdUsesC >= @s im_cdMaxC run scoreboard players operation @s im_abilityCdC > @s im_cdFloorC

# Reset damage inputs now that they've been consumed
scoreboard players set @s im_abilityDealt 0
scoreboard players set @s im_abilityTaken 0

# Dispatch kit abilities for any cooldown that has expired (0 or overshot below it).
execute if score @s im_abilityCdA matches ..0 run function imperium:kit_dispatch
execute if score @s im_abilityCdB matches ..0 run function imperium:kit_dispatch
execute if score @s im_abilityCdC matches ..0 run function imperium:kit_dispatch
