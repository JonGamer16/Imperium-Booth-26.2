# Count-based charges: sync count-tracked slots to the player's real item count, so the
# system can never mismatch the inventory. Only Meowdy's arrows (slot B) use this today;
# the tag gate keeps the inventory scan off every other player.
execute if entity @s[tag=im.kit_meowdy] store result score @s im_cdUsesB run clear @s arrow[custom_data={imperium_kit:1b}] 0

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
