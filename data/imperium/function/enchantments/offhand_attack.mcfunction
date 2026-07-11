# Runs as the victim (affected: "victim"). Deal 5 damage to the entity that was just attacked.
# The attacker's cooldown gate (im_secTimer == 0) lives in the enchantment JSON "requirements",
# so if this function runs at all, the attacker is already off cooldown. Do NOT set the timer
# here: this fires on the mainhand attack and runs as the victim, so it would stamp the wrong
# entity and reset every swing. The timer is set by the right-click function on the attacker.
damage @s 5 imperium:light by @n[distance=0.1..5,tag=im.kit_smokey]
