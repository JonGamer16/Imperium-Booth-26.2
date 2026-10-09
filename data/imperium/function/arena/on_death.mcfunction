# Death handling for a fighter. Driven from imperium:loop_tick by the im_deaths watcher —
# im_deaths is a vanilla `deathCount` objective (declared in main/init_stats), so death detection
# needs no hook at all and never needed Summit's #api/player_died. That hook is parked in zz_archive.
#
# Continuous free-for-all: no lives, no elimination. You die, you pay the gold penalty, you respawn
# and keep playing. The arena/eliminate branch that used to end this file is parked with the rest of
# the round machinery.

# Re-arm the watcher first, so a second death can be seen even if something below returns early.
scoreboard players set @s im_deaths 0
function imperium:arena/calc_gold

# Crosshair tracker (Rastus/Levent): kill the dead player's interaction; aim_tick re-summons a
# fresh one once they're back holding the enchanted weapon.
function imperium:enchantments/aim_free

# Death penalty: forfeit half your current gold. Banked into im_goldLost, a permanent offset that
# calc_gold subtracts, so gold keeps accruing normally afterwards. #lost im.temp holds the amount
# for the message below and is kept through the kill-feed handoff.
#
# NOTE(progression phase): this is still the round-era model, where gold is DERIVED each second by
# calc_gold from kills/damage minus im_goldLost. A persistent bank that you spend on kit unlocks
# wants a real balance rather than a recomputed total, at which point this forfeit becomes a plain
# subtraction and im_goldLost goes away. Left as-is deliberately — reworking it belongs with the
# rest of that model, not here.
scoreboard players operation #lost im.temp = @s im_gold
scoreboard players operation #lost im.temp /= #2 imperium.const
scoreboard players operation @s im_goldLost += #lost im.temp
function imperium:arena/calc_gold

# Kill feed: if a recent fighter dealt the killing blow, broadcast it as that killer. Stash the
# recorded attacker id (#atk) before switching context to the killer (#lost already holds the forfeit).
scoreboard players operation #atk im.temp = @s im_lastAtkId
tag @s add im.feed_victim
execute if score @s im_lastAtkTime matches 1.. as @a[tag=im.fighting] if score @s im_combatId = #atk im.temp run function imperium:arena/kill_feed
tag @s remove im.feed_victim
scoreboard players set @s im_lastAtkId 0
scoreboard players set @s im_lastAtkTime 0

tellraw @s [{"text":" -","color":"red"},{"score":{"name":"#lost","objective":"im.temp"},"color":"gold"},{"text":" gold","color":"red"}]

# Re-equip the kit, but NOT yet — @s is still on the death screen right now. deathCount ticks up the
# instant they die, so this function runs while Health is 0 and the player has not chosen to respawn;
# anything given here lands on a corpse and is wiped by the vanilla respawn that follows. im.await_kit
# defers the re-give to imperium:loop_1s, which hands off to arena/respawn once they are actually
# alive again. (The old Summit path had a standing TODO asking staff whether #api/player_died fired
# before or after the vanilla respawn — this sidesteps the question by observing health instead.)
tag @s add im.await_kit
