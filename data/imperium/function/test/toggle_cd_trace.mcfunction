# Manual test: /function imperium:test/toggle_cd_trace
# Flips #CdTrace im_debug_mode. While 1, every cooldown-engine run prints which trigger fired plus
# a before/after line of the engine's inputs (see test/cd_trace).
execute store success score #CdTrace im_debug_mode unless score #CdTrace im_debug_mode matches 1..
execute if score #CdTrace im_debug_mode matches 1 run tellraw @s {text:"[Imperium] Cooldown trace ON",color:"yellow"}
execute if score #CdTrace im_debug_mode matches 0 run tellraw @s {text:"[Imperium] Cooldown trace OFF",color:"gray"}
