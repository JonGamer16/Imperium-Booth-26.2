# Kill every training-dummy husk but KEEP the home marker(s): the marker is summit.static (schematic-
# managed) and the spawn point, so it stays put for the next summon. Handles accidental duplicate
# husks by clearing them all. Used by the manual "kill husk" command, the dummy interaction
# (dismiss), and the #summit.booth:imperium/entities/kill teardown hook.
kill @e[type=husk,tag=im.dummy]
