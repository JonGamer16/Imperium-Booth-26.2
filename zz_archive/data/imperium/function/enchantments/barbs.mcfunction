# Barbs (fishing rod) — enchant `minecraft:tick` effect, runs AS the holder each tick the rod is
# equipped. Just flag the holder with a 2-tick heartbeat; imperium:loop does the global, once-per-
# tick bobber/hook processing (imperium:enchantments/barbs_hooks) and clears the flag when this
# stops refreshing (rod unequipped).
#
# Previously this function ran `as @a if items entity @s ... *[minecraft:enchantments~[...]]` for
# BOTH hands, re-encoding every player's enchantments data-component twice per tick — and it did so
# once per barbs holder. That component re-encode was a large share of the serialization cost in
# the spark profile; flagging @s directly (the enchant already runs as the holder) removes it.
tag @s add barbs_user
scoreboard players set @s im_barbsEq 2
