# Manual FULL teardown — remove every dummy marker (im.dummy_home) and husk. Use to relocate the
# dummy or clear it entirely. Note the #entities/kill hook uses kill_husk instead (husk only), so
# the static marker survives a normal booth teardown; this is the heavier "wipe it all" command.
kill @e[type=husk,tag=im.dummy]
kill @e[type=marker,tag=im.dummy_home]
