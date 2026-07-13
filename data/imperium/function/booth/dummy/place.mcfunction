# (Re)place the dummy home marker + the dummy at the execution position. For local testing
# stand where the dummy should live and run this directly; production uses dummy/summon.
# The marker is the tether point the 5t loop snaps the dummy back to.
kill @e[type=marker,tag=im.dummy_home]
kill @e[type=husk,tag=im.dummy]
summon minecraft:marker ~ ~ ~ {Tags:["im.dummy_home","summit.booth_entity.imperium","summit.static"]}
function imperium:booth/dummy/respawn
