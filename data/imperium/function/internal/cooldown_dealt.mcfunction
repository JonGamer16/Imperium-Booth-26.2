# Ability cooldown engine — dealt-damage trigger (advancement-driven; replaces the per-tick
# `@a run update_cooldowns` in imperium:loop). Fires from imperium:combat/cooldown_dealt on
# minecraft:player_hurt_entity, as the attacking player. Cooldowns only ever change via
# im_abilityDealt / im_abilityTaken, so running the engine only on damage events is exact and
# costs nothing on quiet ticks. Re-arm, then run the engine if the player is in the arena.
advancement revoke @s only imperium:combat/cooldown_dealt

# Charge the engine anywhere abilities are live — arena AND booth. The victim being a valid target
# is enforced up in the advancement (entity type #imperium:human: players, mannequins, and the
# training-dummy husk), so hitting a kit stand or a stray mob still charges nothing.
# The old `if entity @s[tag=im.fighting]` guard here is what kept the booth dummy from ever
# recharging an ability: im.fighting is added by arena/start_round, so it is absent in the booth.
# It was redundant on the arena path anyway — the imperium:battlegrounds branch of ability_zone
# already requires BOTH im.fighting and summit.battlegrounds.player, so dropping it changes
# nothing in a real match and only opens up the booth.
function imperium:update_cooldowns

# Gold scoring stays arena-only: ability_zone also passes in the booth, and without this guard
# whacking the training dummy would print "[Damage Bonus] +N Gold" and bank match score.
execute if entity @s[tag=im.fighting] run function imperium:arena/gold_dmg_bonus
