# imperium:motion — player launch module. Replaces the Summit-core player_motion library.
#
# Launch @s (a player) by a WORLD-space velocity, added on top of their current momentum.
#   in:  $x / $y / $z im.motion   velocity in 1/10000 blocks/tick (30000 = 3 b/t). Not modified.
#   out: return 1 if a launch was applied, 0 for a zero vector, fail for an unsupported player.
#
# Players ignore /data writes to Motion, so the velocity goes in through the enchantment
# imperium:motion_impulse instead: its minecraft:apply_impulse effects push along the player's
# LOCAL axes (left / up / forward), one effect per bit of each axis. This function converts the
# world vector into that local frame, and internal/apply fires it.
#
# Costs nothing when unused: no tick function, no forceloaded chunk, no persistent entity. The
# temporary marker in internal/basis lives only for the duration of this call.
#
# LIMITS
#   - Per-axis input is clamped to +/-131071 (~13 b/t); the enchantment encodes 18 bits per axis.
#   - Non-players, spectators and mounted players are refused, as the old library did.
#   - Positions are read at x1000, so this misbehaves beyond ~2,147,000 blocks from 0,0.

# Players only: other entities take Motion NBT directly, and the saddle would actually saddle them.
execute if entity @s[type=!player] run return fail
execute if entity @s[gamemode=spectator] run return fail
execute on vehicle run return fail

scoreboard players operation #gx im.motion = $x im.motion
scoreboard players operation #gy im.motion = $y im.motion
scoreboard players operation #gz im.motion = $z im.motion
execute \
    if score #gx im.motion matches 0 \
    if score #gy im.motion matches 0 \
    if score #gz im.motion matches 0 \
    run return 0

# Clamp before the dot products: 131071 x 1000 x 3 stays inside a 32-bit score.
scoreboard players operation #gx im.motion < #max im.motion
scoreboard players operation #gx im.motion > #min im.motion
scoreboard players operation #gy im.motion < #max im.motion
scoreboard players operation #gy im.motion > #min im.motion
scoreboard players operation #gz im.motion < #max im.motion
scoreboard players operation #gz im.motion > #min im.motion

# The player's own left (i) / up (j) / forward (k) unit vectors, x1000. `at @s` puts the marker
# in the player's rotation; the launch frame is always the player's view, never the caller's.
execute at @s summon minecraft:marker run function imperium:motion/internal/basis

# World -> local: each local component is the dot product with that basis vector. Left has no
# y component, so i skips it.
scoreboard players operation #lx im.motion = #ix im.motion
scoreboard players operation #lx im.motion *= #gx im.motion
scoreboard players operation #t im.motion = #iz im.motion
scoreboard players operation #t im.motion *= #gz im.motion
scoreboard players operation #lx im.motion += #t im.motion

scoreboard players operation #ly im.motion = #jx im.motion
scoreboard players operation #ly im.motion *= #gx im.motion
scoreboard players operation #t im.motion = #jy im.motion
scoreboard players operation #t im.motion *= #gy im.motion
scoreboard players operation #ly im.motion += #t im.motion
scoreboard players operation #t im.motion = #jz im.motion
scoreboard players operation #t im.motion *= #gz im.motion
scoreboard players operation #ly im.motion += #t im.motion

scoreboard players operation #lz im.motion = #kx im.motion
scoreboard players operation #lz im.motion *= #gx im.motion
scoreboard players operation #t im.motion = #ky im.motion
scoreboard players operation #t im.motion *= #gy im.motion
scoreboard players operation #lz im.motion += #t im.motion
scoreboard players operation #t im.motion = #kz im.motion
scoreboard players operation #t im.motion *= #gz im.motion
scoreboard players operation #lz im.motion += #t im.motion

scoreboard players operation #lx im.motion /= #1000 im.motion
scoreboard players operation #ly im.motion /= #1000 im.motion
scoreboard players operation #lz im.motion /= #1000 im.motion

# Looking straight up, the impulse's local frame disagrees with execute's ^ frame.
execute if entity @s[x_rotation=-90] run function imperium:motion/internal/polar

function imperium:motion/internal/apply
return 1
