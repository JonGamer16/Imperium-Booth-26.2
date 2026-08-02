# Manual FULL teardown — remove every dummy marker (im.dummy_home) and mob. Use to relocate the
# dummy or clear it entirely. Note the #entities/kill hook uses kill_husk instead (mob only), so
# the static marker survives a normal booth teardown; this is the heavier "wipe it all" command.
# Tag-only selector, no `type=husk` — see kill_husk for why (drowned conversion).
kill @e[tag=im.dummy]
kill @e[type=marker,tag=im.dummy_home]
