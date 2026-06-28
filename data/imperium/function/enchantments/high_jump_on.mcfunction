# high_jump_on - apply the low-gravity modifier and flag it active
attribute @s gravity modifier add im_high_jump -0.8 add_multiplied_base
scoreboard players set @s im_high_jump 1
