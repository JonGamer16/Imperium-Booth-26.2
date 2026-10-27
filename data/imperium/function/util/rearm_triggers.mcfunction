# Re-arm every self-revoking imperium advancement trigger. Each one is revoked by its own reward
# function, so if that function ever fails mid-way (or fails to load, e.g. during a version port)
# the advancement stays granted and the trigger is silently dead for that player until revoked.
# Run on load (main, all online players) and on every kit equip (arena/givekit), which catches
# players who were offline during the load. Named one by one: `revoke everything` would also
# strip vanilla survival advancements. Add a line here when adding an advancement (test/ probes
# excluded: they're temporary).
# A dealt hit still waiting on its 1t flush (internal/cooldown_dealt) when a reload/restart dropped
# the schedule: apply it now, or cooldown_taken would keep deferring to a flush that never comes.
execute if entity @s[tag=im.cd_dealt_pending] run function imperium:internal/cooldown_dealt_apply

advancement revoke @s only imperium:attack_player
advancement revoke @s only imperium:booth/clear
advancement revoke @s only imperium:booth/dummy_toggle
advancement revoke @s only imperium:booth/link_discord
advancement revoke @s only imperium:booth/link_github
advancement revoke @s only imperium:booth/random
advancement revoke @s only imperium:booth/select_cliffshield
advancement revoke @s only imperium:booth/select_levent
advancement revoke @s only imperium:booth/select_livvy
advancement revoke @s only imperium:booth/select_meowdy
advancement revoke @s only imperium:booth/select_mummy
advancement revoke @s only imperium:booth/select_rastus
advancement revoke @s only imperium:booth/select_smokey
advancement revoke @s only imperium:booth/warp_from_kitroom
advancement revoke @s only imperium:booth/warp_from_shulkerbox
advancement revoke @s only imperium:combat/cooldown_dealt
advancement revoke @s only imperium:combat/cooldown_dealt_human
advancement revoke @s only imperium:combat/cooldown_taken
advancement revoke @s only imperium:combat/hurt_by_player
advancement revoke @s only imperium:combat/rod_broke
advancement revoke @s only imperium:combat/shot_arrow
advancement revoke @s only imperium:combat/venom_bite
advancement revoke @s only imperium:enchantments/reversal_block
advancement revoke @s only imperium:leave_spawn
advancement revoke @s only imperium:levent_chorus
advancement revoke @s only imperium:levent_shield
advancement revoke @s only imperium:raise_shield
advancement revoke @s only imperium:rastus_air_dodge
advancement revoke @s only imperium:rastus_parry_cue
advancement revoke @s only imperium:rastus_strike_cue
advancement revoke @s only imperium:use_kinetic_weapon
advancement revoke @s only imperium:use_leap_feather
advancement revoke @s only imperium:use_marking_dart
