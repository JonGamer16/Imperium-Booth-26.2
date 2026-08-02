# Manual FULL teardown — remove every dummy marker (im.dummy_home) and mob. Use to relocate the
# dummy or clear it entirely. Note the #entities/kill hook uses kill_husk instead (mob only), so
# the static marker survives a normal booth teardown; this is the heavier "wipe it all" command.
# `#minecraft:zombies` type filter, never a bare `type=husk` — see kill_husk for why (conversion).
kill @e[type=#minecraft:zombies,tag=im.dummy]
kill @e[type=marker,tag=im.dummy_home]
