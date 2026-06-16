# Incremental arrow refill: give ONE arrow toward max, then restart the cooldown.
# Count-based slot, so we never touch im_cdUsesB here -- update_cooldowns recounts the
# real ammo each tick. Do NOT clear first; that would wipe the arrows he still has.
# The freeze (uses >= max) stops this from over-refilling past the stack.
loot give @s loot imperium:meowdy/arrow
scoreboard players operation @s im_abilityCdB += #Meowdy im_abilityCdB
