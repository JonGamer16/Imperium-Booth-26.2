# Crystal Bomb — RESOURCE GIVEBACK only (placement entity, fuse timer, and explosion are added in
# later steps). Placing a crystal as a bomb instead of eating it still returns some health and energy
# to the Mummy, but reduced versus a normal eat. Runs as the placing Mummy.
#
# NOTE: crystal_consume routes here ONLY on a sneak-consume (the standing path is crystal_eat), so the
# two refunds are mutually exclusive — the energy below is the sole refund on the bomb path, no double.

# Reduced heal: the consumable already applied instant_health + regeneration on consume; strip the
# regen so the bomb heals noticeably less than eating the crystal (keeps just the instant tick).
effect clear @s minecraft:regeneration

# Reduced energy ("charge") back, capped at the max.
scoreboard players operation @s im_energy += #MummyCrystalBombEnergy im.param
execute if score @s im_energy > #MummyEnergyMax im.param run scoreboard players operation @s im_energy = #MummyEnergyMax im.param

# Barrier is up (you sneak to place), so re-project the refreshed energy onto the absorption hearts —
# otherwise the barrier hold-sync reads the unchanged hearts next tick and erases the refund.
execute if entity @s[tag=im.barrier_up] run function imperium:kits/mummy/barrier_apply

# Place the bomb at the Mummy's feet: an Invulnerable end crystal so it can't be attacked into its
# vanilla block-breaking blast (anti-grief), beam-to-bedrock hidden. bomb_init starts the fuse this
# same tick; bomb_detonate /kills it when the fuse expires (command-kill doesn't trigger the blast).
summon end_crystal ~ ~ ~ {Invulnerable:1b,ShowBottom:0b,Tags:["im.crystal_bomb"]}

# Pair this bomb to its placer via a shared id (im_bombId) so the blast spares the owner. Stamp the
# next id on the placer (@s) and on the just-summoned crystal (the nearest not-yet-initialized bomb).
scoreboard players add #next im_bombId 1
scoreboard players operation @s im_bombId = #next im_bombId
execute as @e[type=end_crystal,tag=im.crystal_bomb,tag=!im.bomb_live,sort=nearest,limit=1] run scoreboard players operation @s im_bombId = #next im_bombId

# Placement telegraph: a bright chime + a tnt-fuse hiss so nearby players hear the bomb go live.
playsound minecraft:block.beacon.activate player @a[distance=..32] ~ ~ ~ 1 1.7
playsound minecraft:entity.tnt.primed player @a[distance=..32] ~ ~ ~ 1 1.3
