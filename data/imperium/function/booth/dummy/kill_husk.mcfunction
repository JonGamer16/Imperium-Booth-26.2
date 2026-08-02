# Kill every training-dummy mob but KEEP the home marker(s): the marker is summit.static (schematic-
# managed) and the spawn point, so it stays put for the next summon. Handles accidental duplicate
# husks by clearing them all. Used by the manual "kill husk" command, the dummy interaction
# (dismiss), the booth-empty sweep (dummy/empty_check), and the
# #summit.booth:imperium/entities/kill teardown hook.
#
# Matched by `type=#minecraft:zombies` + the tag — NEVER a bare `type=husk`. A dummy that escapes
# into the cave river converts husk -> zombie -> drowned, and an exact-type selector stops matching
# it the moment it does — which is exactly how one escapee became permanent. The vanilla
# #minecraft:zombies tag spans that whole chain (husk, zombie, drowned), so the selector still
# can't miss a converted dummy while giving @e a positive type filter instead of a scan of every
# entity in the world. The tag is what actually picks the dummy out: nothing else in the pack
# carries bare `im.dummy` (the markers are `im.dummy_home`, a different string — tag matching is
# exact). Every other `im.dummy` selector in the pack uses this same type filter.
kill @e[type=#minecraft:zombies,tag=im.dummy]
