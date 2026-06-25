# Close the parry bubble: strip the Resistance + knockback resistance the moment the window
# expires. Park im_parryWindow at -1 so the loop's `=0` check fires this exactly once.
attribute @s minecraft:knockback_resistance modifier remove imperium:parry
effect clear @s minecraft:resistance
scoreboard players set @s im_parryWindow -1

# Close the deflect window and re-arm the cue advancement for the next parry (in case the
# window expired without taking a hit, leaving the advancement still earned).
tag @s remove im.rastus_parrying
advancement revoke @s only imperium:rastus_parry_cue
