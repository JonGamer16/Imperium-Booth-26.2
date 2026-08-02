# Kill every training-dummy mob but KEEP the home marker(s): the marker is summit.static (schematic-
# managed) and the spawn point, so it stays put for the next summon. Handles accidental duplicate
# husks by clearing them all. Used by the manual "kill husk" command, the dummy interaction
# (dismiss), the booth-empty sweep (dummy/empty_check), and the
# #summit.booth:imperium/entities/kill teardown hook.
#
# Matched by TAG ALONE, no `type=husk`. A dummy that escapes into the cave river converts
# husk -> zombie -> drowned, and a type-scoped selector stops matching it the moment it does —
# which is exactly how one escapee became permanent. Nothing else in the pack carries the bare
# `im.dummy` tag (the markers are `im.dummy_home`, a different string — tag matching is exact),
# so dropping the type filter costs no precision.
kill @e[tag=im.dummy]
