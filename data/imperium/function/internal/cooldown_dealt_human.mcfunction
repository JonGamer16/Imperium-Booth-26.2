# Marks this tick's dealt damage as full-weight (target was #imperium:human). Fires alongside
# combat/cooldown_dealt on the same hit; internal/cooldown_dealt_apply reads and clears the tag.
advancement revoke @s only imperium:combat/cooldown_dealt_human
tag @s add im.cd_hit_human
