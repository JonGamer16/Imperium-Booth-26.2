advancement revoke @s only imperium:use_marking_dart

# Spend a charge (Smokey slot B); update_cooldowns clamps this at >= 0.
scoreboard players remove @s im_cdUsesB 1

# Compute look direction at arrow speed (strength 30000 -> 3.0 bl/t)
scoreboard players set $strength player_motion.api.launch 30000
execute store result storage player_motion:math strength double 0.0001 \
    run scoreboard players get $strength player_motion.api.launch

# Borrow player_motion direction trick: TP helper entity from origin by ^strength,
# read resulting Pos as the look-direction vector, then return it to origin.
# execute as preserves the caller's rotation context onto the helper entity.
# (summit-core keeps this legacy math under internal/old/; the marker UUID is the
# same one summit-core's player_motion:internal/init summons.)
execute \
    as d4bd74a7-4e82-4a07-8850-dfc4d89f9e2f \
    in minecraft:overworld \
    positioned 0.0 0.0 0.0 \
    run function player_motion:internal/old/math/looking_to_xyz with storage player_motion:math

# Summon a Bad Omen tipped arrow 0.3 blocks forward at eye level, tag it for targeting.
# Bad Omen is only the on-hit SIGNAL — vanilla has no native "arrow applied a tag", so the
# arrow's held item carries it and imperium:loop converts any hit player to the im.marked
# tag (then strips the effect). The Marked enchantment reads that tag for bonus damage.
# Duration just needs to survive until the next loop tick catches it.
execute at @s anchored eyes \
    run summon minecraft:arrow ^ ^ ^0.3 \
        {Tags:["im.dart_projectile"],\
         item:{id:"minecraft:tipped_arrow",count:1,components:{"minecraft:potion_contents":{custom_effects:[{id:"minecraft:bad_omen",amplifier:0,duration:1600}]}}}}

# Apply direction as Motion and set owner (prevents self-hit grace period)
data modify entity @e[type=arrow,tag=im.dart_projectile,limit=1,sort=nearest] \
    Motion set from storage player_motion:math motion
data modify entity @e[type=arrow,tag=im.dart_projectile,limit=1,sort=nearest] \
    damage set value 2.0f
data modify entity @e[type=arrow,tag=im.dart_projectile,limit=1,sort=nearest] \
    Owner set from entity @s UUID
