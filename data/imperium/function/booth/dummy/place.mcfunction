# Manual "create dummy" — stand where the dummy should live and run this. Clears any existing dummy
# (one marker at a time), drops the home marker here, then spawns the equipped husk on it via
# respawn. summit.static: the marker rides the schematic and is restored on booth load, at which
# point #entities/summon respawns the husk against it — so production dummies come up through that
# hook, not this command.
kill @e[type=marker,tag=im.dummy_home]
kill @e[type=husk,tag=im.dummy]
summon minecraft:marker ~ ~ ~ {Tags:["im.dummy_home","summit.booth_entity.imperium","summit.static"]}
function imperium:booth/dummy/respawn
