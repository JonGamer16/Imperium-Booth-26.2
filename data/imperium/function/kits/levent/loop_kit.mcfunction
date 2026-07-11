# High Jump: strip the orphaned low-gravity modifier when the armor is unequipped mid-jump.
#   The enchant's tick refreshes im_high_jump_eq to 2 every tick it's worn. Here we tick that
#   down ONLY for players currently in high-jump gravity (im_high_jump=1) — a tiny set — and
#   when it reaches 0 (no enchant tick for 2 ticks = unequipped) we remove the leftover modifier.
execute \
    if score @s im_high_jump_eq matches 1.. \
    run scoreboard players remove @s im_high_jump_eq 1
execute \
    if score @s im_high_jump_eq matches 0 \
    run function imperium:enchantments/high_jump_off