# Crystal Bomb fuse expired (runs as the end crystal, at it). Deal the ringed falloff damage, clear the
# per-target hit tags, then remove the crystal. /kill is terrain-safe — command-kill doesn't trigger the
# end crystal's blast, and Invulnerable already blocks attack-triggered ones.
# Remember this bomb's owner-pairing id so bomb_hurt can spare the placer.
scoreboard players operation #thisBomb im_bombId = @s im_bombId

# Blast FX: standard explosion puff + a burst of enchant-hit sparkle, over a crystalline shatter + boom.
particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1 normal
playsound minecraft:block.amethyst_block.break player @a[distance=..48] ~ ~ ~ 1 1
playsound minecraft:entity.generic.explode player @a[distance=..48] ~ ~ ~ 1 1

scoreboard players set #bombRing im.temp 0
function imperium:kits/mummy/bomb_damage_ring

# Launch everything the blast hit straight up — the placer included (self-boost; they still take no
# damage, only the pop).
execute as @e[tag=im.bomb_hit] run function imperium:kits/mummy/bomb_launch

tag @e[tag=im.bomb_hit] remove im.bomb_hit
kill @s
