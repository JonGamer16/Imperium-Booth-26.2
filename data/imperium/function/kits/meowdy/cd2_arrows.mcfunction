# Incremental arrow refill: give ONE arrow toward max, then restart the cooldown.
# Do NOT clear first; that would wipe the arrows he still has. The freeze (uses >= max) stops
# this from over-refilling past the stack.
loot give @s loot imperium:meowdy/arrow
# Re-sync the charge count to the new real ammo so the freeze re-engages once full. There is no
# per-tick recount anymore (see imperium:internal/arrow_recount), so the refill must do it here.
execute store result score @s im_cdUsesB run clear @s arrow[custom_data~{imperium_kit:1b}] 0
scoreboard players operation @s im_abilityCdB += #Meowdy im_abilityCdB
