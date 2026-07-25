# Livvy landed a melee hit on a venom-affected target (imperium:combat/venom_bite). Grant a flat
# lifesteal bonus on top of the hit's normal damage-based score, then re-arm the trigger. The
# advancement already gates on player=im.kit_livvy, victim=im.venom, and a non-no_impact damage type
# (so the venom DoT itself can't fire this), so no extra checks are needed here.
advancement revoke @s only imperium:combat/venom_bite
scoreboard players operation @s im_lifesteal += #VenomLsBonus im_lifesteal
