# Core tick: runs regardless of kits, so the core enchantments clean up after themselves in any world.

# High Jump: strip the orphaned low-gravity modifier when the armor is unequipped mid-jump.
#   The enchant's tick refreshes im_high_jump_eq to 2 every tick it's worn. Tick it down only for
#   players in high-jump gravity; at 0 (no enchant tick for 2 ticks = unequipped) remove the modifier.
#   This must be the ONLY place that ticks it down: a second decrement per tick reaches 0 while the
#   armor is still worn and flickers the gravity off and on.
scoreboard players remove @a[scores={im_high_jump=1,im_high_jump_eq=1..}] im_high_jump_eq 1
execute as @a[scores={im_high_jump=1,im_high_jump_eq=0}] run function imperium:enchantments/high_jump_off

# Own 1-second clock (kit PvP's #1s lives in its own tick and may not be loaded).
scoreboard players add #core1s im.temp 1
execute if score #core1s im.temp matches 20.. run function imperium:core/second
