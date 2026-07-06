# Reward of imperium:combat/hurt_by_player (fires as @s = the hurt player). Record who hit @s for
# the kill feed. `execute on attacker` resolves the damaging entity (works inside a damage event,
# unlike at death time). We only store it if the attacker is a fighter and isn't @s themselves, and
# refresh a 10s credit window so a stale hit can't be blamed for a later fall/environmental death.
advancement revoke @s only imperium:combat/hurt_by_player
execute unless entity @s[tag=im.fighting] run return 0

# Read the attacker's combat id into a temp (stays -1 if there's no fighter attacker).
scoreboard players set #atkId im.temp -1
execute on attacker if entity @s[tag=im.fighting] run scoreboard players operation #atkId im.temp = @s im_combatId

# Back as the victim: record it unless it's self-damage.
execute if score #atkId im.temp matches 1.. unless score #atkId im.temp = @s im_combatId run scoreboard players operation @s im_lastAtkId = #atkId im.temp
execute if score #atkId im.temp matches 1.. unless score #atkId im.temp = @s im_combatId run scoreboard players set @s im_lastAtkTime 10
