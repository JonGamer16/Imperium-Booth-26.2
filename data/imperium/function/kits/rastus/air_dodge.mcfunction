# Superior Agility (Rastus) — air dodge. Reward of imperium:rastus_air_dodge, which a Rastus
# player earns the tick they hold sneak while airborne (sneak + OnGround:0b are gated in the
# advancement). Launches ~2 blocks along the held movement direction, horizontal plane only
# (pitch -> 0).
#
# COOLDOWN: the Strike & Parry charge (im_melee_drought, armed at #StrikeCharge idle ticks and
# flagged by im.rastus_focused). A dodge requires it armed and spends it, so the next dodge needs
# another #StrikeCharge ticks of not attacking, blocking or dodging — ~0.6s, roughly one dodge per
# normal jump, but a long airtime (grapple, bomb launch, dodge chain) can buy a second once the
# charge rearms. This REPLACED the old once-per-airtime lock, which worked by leaving the
# advancement earned until loop_kit revoked it on landing; every path below now revokes, so the
# charge is the only limiter and imperium:kits/rastus/loop_kit no longer revokes on the ground.
#
# The charge is shared with the Strike (boosted hit) and the Parry (full-deflect raise) — all three
# compete for it, so dodging disarms a ready Strike and vice versa. That is deliberate.
#
# Every refusal below revokes so the player can re-earn (and dodge) later in this same airtime the
# moment the missing thing arrives, rather than being locked out until they land.

#   Require the shared charge to be armed. Cheapest check (a tag), and the one that fails most
#   often, so it goes first. No refusal cue: focus_on already dings when the charge lands, and the
#   actionbar belongs to the dash stock readout (rastus/dash_count) — a second writer would just
#   clobber it.
execute if entity @s[tag=!im.rastus_focused] run return run advancement revoke @s only imperium:rastus_air_dodge

#   Require a stored dash charge (slot C; cd3_dodge banks one per 5 HP dealt). The actionbar
#   re-fires each held tick, which just keeps the message on screen.
execute if score @s im_cdUsesC matches ..0 run title @s actionbar {"text":"✖ No dash charges","color":"red"}
execute if score @s im_cdUsesC matches ..0 run return run advancement revoke @s only imperium:rastus_air_dodge

#   Require a held WASD direction — dodge_launch has no fallback if none is pressed.
execute \
    unless predicate imperium:player_input/forward \
    unless predicate imperium:player_input/backward \
    unless predicate imperium:player_input/left \
    unless predicate imperium:player_input/right \
    run return run advancement revoke @s only imperium:rastus_air_dodge

#   Launch strength — lateral hop distance, in 0.0001 b/t units (matches player_motion).
scoreboard players operation \
    $strength player_motion.api.launch = #DodgePower im.param

#   Horizontal launch in the held direction.
function imperium:kits/rastus/dodge_launch

#   Spend the dash charge so the slot-C cooldown starts running (update_cooldowns clamps at >= 0).
scoreboard players remove @s im_cdUsesC 1

#   Spend the shared charge — this is the dodge's cooldown. Zeroing im_melee_drought is what
#   actually gates the next dodge; focus_off strips the Strike attribute boost right now instead of
#   waiting for loop_kit to notice next tick. (Parry spends the charge the same way, minus the
#   immediate strip — it has a reason to keep the tag for the rest of its tick, this does not.)
scoreboard players set @s im_melee_drought 0
function imperium:kits/rastus/focus_off

#   Re-arm the trigger. With the landing revoke gone this is the ONLY thing that lets a later dodge
#   fire; the charge gate above is what stops the re-earn from dodging again immediately.
advancement revoke @s only imperium:rastus_air_dodge

#   Count just changed — repost the stock readout (shared with cd3_dodge's refill side).
function imperium:kits/rastus/dash_count

playsound minecraft:entity.player.attack.sweep player @s ~ ~ ~ 0.6 1.6
particle minecraft:cloud ~ ~ ~ 0.2 0.1 0.2 0.02 12
