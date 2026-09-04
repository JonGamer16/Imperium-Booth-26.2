# high_jump_on - apply the low-gravity modifier and flag it active
#
# The modifier id MUST stay namespaced. It used to be the bare `im_high_jump`, which the game
# resolves to `minecraft:im_high_jump` — squatting in a namespace this booth does not own, on an
# attribute (gravity) any other booth may also be modifying. Same class of problem as the Super
# Smash Bros booth's `ssbrc:booth` modifier on entity_interaction_range. Distinct ids stack rather
# than overwrite, so `imperium:` is both correct and the only way ours stays ours to remove.
attribute @s minecraft:gravity modifier add imperium:high_jump -0.8 add_multiplied_base
scoreboard players set @s im_high_jump 1
