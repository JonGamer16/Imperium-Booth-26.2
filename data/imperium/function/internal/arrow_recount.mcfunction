# Count-based arrow slot — resync (advancement-driven; replaces the per-tick recount that used
# to sit at the top of imperium:update_cooldowns). Fires from imperium:combat/shot_arrow on
# minecraft:shot_crossbow, as the shooter. Shooting a crossbow consumes one kit arrow, so we
# re-read the real ammo into the slot-B charge count. This unfreezes the slot so it can refill.
#
# REUSABLE: any kit whose count-based arrow ability lives on slot B (im_cdMaxB >= 1) and whose
# arrows carry custom_data {imperium_kit:1b} is handled here — Meowdy today, Cliffshield next.
# The im_cdMaxB gate skips every other kit so a stray crossbow shot can't disturb their slot B.
advancement revoke @s only imperium:combat/shot_arrow
execute if score @s im_cdMaxB matches 1.. store result score @s im_cdUsesB run clear @s arrow[custom_data~{imperium_kit:1b}] 0
