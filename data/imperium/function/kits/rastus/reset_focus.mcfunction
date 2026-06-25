# Sword Swung — run by the Focus Attack enchant's post_piercing_attack effect (as @s = the
# attacking Rastus). The boosted attributes already applied to this hit; now spend the shared
# charge and strip the boost so the next Strike needs a fresh #StrikeCharge of not acting.
scoreboard players set @s im_melee_drought 0
# NOTE: don't strip the boost here. The loop's focus_off (next tick, once the charge reads
# below #StrikeCharge) handles it — leaving im.rastus_focused set for the rest of THIS tick is
# what lets the rastus_strike_cue advancement (player_hurt_entity, gated on that tag) fire.
