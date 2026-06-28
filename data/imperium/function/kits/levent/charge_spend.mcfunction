# Rod Jabbed — run by the Charge Attack enchant's post_piercing_attack effect (as @s = the
# attacking Levent). post_piercing_attack fires on EVERY jab, whether or not it connects, so any
# swing — hit OR whiff — spends the charge. Zero it now; the loop's charge_off strips the boost
# next tick (leaving the bonus applied to THIS swing if it landed). Mirror of Rastus's reset_focus.
scoreboard players set @s im_leventCharge 0
