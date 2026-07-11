# Runs AS the attacking player when they land a kinetic-weapon (minecraft:spear) hit — i.e. a
# right-click charge with the Sweeping Hatchet. The #imperium:kinetic damage-type tag isolates
# the spear hit from a normal melee player_attack, so this never fires on a left-click swing.
# Re-arm the advancement, then stamp the Offhand Attack cooldown so the mainhand offhand_attack
# bonus is inhibited for 20 ticks (1s) — spam-charging keeps it pinned at 20.
advancement revoke @s only imperium:use_kinetic_weapon
execute if entity @s[tag=im.kit_smokey] run scoreboard players set @s im_offhandCd 20
