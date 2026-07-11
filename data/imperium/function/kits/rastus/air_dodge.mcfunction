# Superior Agility (Rastus) — air dodge. Reward of imperium:rastus_air_dodge, which a Rastus
# player earns the tick they hold sneak while airborne (sneak + OnGround:0b are gated in the
# advancement). The advancement stays earned, so the reward can't re-fire until it's revoked
# -- which only happens on landing (imperium:loop) or kit swap (util/clear_kit). That earned
# state IS the once-per-airtime lock: holding or mashing sneak mid-air yields no second dodge.
# Launches ~2 blocks along the held movement direction, horizontal plane only (pitch -> 0).

#   Require a held WASD direction. Without one, revoke so the player can still earn (and dodge)
#   this same airtime once they press a direction, instead of being locked out while earned.
execute \
    unless predicate player_input:forward \
    unless predicate player_input:backward \
    unless predicate player_input:left \
    unless predicate player_input:right \
    run return run advancement revoke @s only imperium:rastus_air_dodge

#   Require a stored dash charge (slot C; cd3_dodge banks one per 5 HP dealt). Out of
#   charges -> no dodge; revoke so a charge earned mid-air (falling hit) re-enables this
#   same airtime, same re-arm philosophy as the no-direction branch above. The actionbar
#   re-fires each held tick, which just keeps the message on screen.
execute if score @s im_cdUsesC matches ..0 run title @s actionbar {"text":"✖ No dash charges","color":"red"}
execute if score @s im_cdUsesC matches ..0 run return run advancement revoke @s only imperium:rastus_air_dodge

#   Launch strength — lateral hop distance, in 0.0001 b/t units (matches player_motion).
scoreboard players operation \
    $strength player_motion.api.launch = #DodgePower im.param

#   Horizontal launch in the held direction; advancement stays earned -> locked until landing.
function imperium:kits/rastus/dodge_launch

#   Spend the charge so the slot-C cooldown starts running (update_cooldowns clamps at >= 0).
scoreboard players remove @s im_cdUsesC 1

playsound minecraft:entity.player.attack.sweep player @s ~ ~ ~ 0.6 1.6
particle minecraft:cloud ~ ~ ~ 0.2 0.1 0.2 0.02 12
