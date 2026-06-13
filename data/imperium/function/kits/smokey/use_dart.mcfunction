advancement revoke @s only imperium:use_marking_dart

# Compute look direction at arrow speed (strength 30000 -> 3.0 bl/t)
scoreboard players set $strength player_motion.api.launch 30000
execute store result storage player_motion:math strength double 0.0001 \
    run scoreboard players get $strength player_motion.api.launch

# Borrow player_motion direction trick: TP helper entity from origin by ^strength,
# read resulting Pos as the look-direction vector, then return it to origin.
# execute as preserves the caller's rotation context onto the helper entity.
execute \
    as d4bd74a7-4e82-4a07-8850-dfc4d89f9e2f \
    in minecraft:overworld \
    positioned 0.0 0.0 0.0 \
    run function player_motion:internal/math/looking_to_xyz with storage player_motion:math

# Summon spectral arrow 0.3 blocks forward at eye level, tag it for targeting
execute at @s anchored eyes \
    run summon minecraft:spectral_arrow ^ ^ ^0.3 {Tags:["im.dart_projectile"]}

# Apply direction as Motion and set owner (prevents self-hit grace period)
data modify entity @e[type=spectral_arrow,tag=im.dart_projectile,limit=1,sort=nearest] \
    Motion set from storage player_motion:math motion
data modify entity @e[type=spectral_arrow,tag=im.dart_projectile,limit=1,sort=nearest] \
    damage set value 2.0f
data modify entity @e[type=spectral_arrow,tag=im.dart_projectile,limit=1,sort=nearest] \
    Owner set from entity @s UUID
