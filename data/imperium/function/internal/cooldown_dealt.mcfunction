# Ability cooldown engine — dealt-damage trigger (advancement-driven). Fires from
# imperium:combat/cooldown_dealt on minecraft:player_hurt_entity against ANY target, as the
# attacking player. Re-arm, then defer the engine one tick (internal/cooldown_flush).
#
# Why defer: player_hurt_entity fires from inside the victim's hurt handling, before the attack
# awards the damage_dealt stat, so im_abilityDealt doesn't hold this hit yet. Running the engine
# here charged each hit with the PREVIOUS hit's damage. One tick later the stat is settled.
#
# Weighting: hits on #imperium:human (players, mannequins, the training-dummy husk) charge 1:1;
# anything else (mobs, golems) charges 1/3. combat/cooldown_dealt_human tags the human hits; the
# flush divides the tick's dealt damage by 3 when no human was hit. A sweep that hits a human AND
# a mob in one tick counts entirely as human — the stat can't split one tick's damage by target.
#
# Formerly human-only, which was the "have to take damage first" bug: the damage_dealt stat counts
# every target, so mob damage piled up in im_abilityDealt with nothing consuming it until a
# cooldown_taken run spent it all at once.
advancement revoke @s only imperium:combat/cooldown_dealt
execute if score #CdTrace im_debug_mode matches 1 run tellraw @s {text:"[cd] trigger: dealt",color:"gold"}

tag @s add im.cd_dealt_pending
schedule function imperium:internal/cooldown_flush 1t replace
