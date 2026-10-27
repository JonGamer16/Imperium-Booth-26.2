# Manual test: /function imperium:test/toggle_zone
# Flips #ZoneBypass im.dmg. While it is 1, imperium:ability_zone passes for EVERY player, kit or
# not, so the cooldown engine (combat/cooldown_dealt + cooldown_taken), kinetic charge, and every
# other ability_zone-gated advancement fire regardless of im.kitted. Unset = 0 = normal gate.
# Not set by main, so it survives /reload; turn it back off before a real session.
execute store success score #ZoneBypass im.dmg unless score #ZoneBypass im.dmg matches 1..
execute if score #ZoneBypass im.dmg matches 1 run tellraw @s {text:"[Imperium] Ability zone bypass ON: abilities/cooldowns ignore im.kitted",color:"yellow"}
execute if score #ZoneBypass im.dmg matches 0 run tellraw @s {text:"[Imperium] Ability zone bypass OFF: normal im.kitted gate",color:"gray"}
