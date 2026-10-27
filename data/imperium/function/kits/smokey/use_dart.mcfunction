advancement revoke @s only imperium:use_marking_dart

# Spend a charge (Smokey slot B); update_cooldowns clamps this at >= 0.
scoreboard players remove @s im_cdUsesB 1

# Compute look direction at arrow speed (strength 30000 -> 3.0 bl/t) into $x/$y/$z im.motion.
# get_looking only computes the vector, it launches nothing.
scoreboard players set $strength im.motion 30000
function imperium:motion/get_looking

# Summon a Bad Omen tipped arrow 0.3 blocks forward at eye level, tag it for targeting.
# Bad Omen is only the on-hit SIGNAL — vanilla has no native "arrow applied a tag", so the
# arrow's held item carries it and imperium:loop converts any hit player to the im.marked
# tag (then strips the effect). The Marked enchantment reads that tag for bonus damage.
# Duration just needs to survive until the next loop tick catches it.
execute at @s anchored eyes \
    run summon minecraft:arrow ^ ^ ^0.3 \
        {Tags:["im.dart_projectile","im.owned"],\
         item:{id:"minecraft:tipped_arrow",count:1,components:{"minecraft:potion_contents":{custom_effects:[{id:"minecraft:bad_omen",amplifier:0,duration:1600}]}}}}

# Apply direction as Motion and set owner (prevents self-hit grace period)
execute store result entity @e[type=arrow,tag=im.dart_projectile,limit=1,sort=nearest] Motion[0] double 0.0001 \
    run scoreboard players get $x im.motion
execute store result entity @e[type=arrow,tag=im.dart_projectile,limit=1,sort=nearest] Motion[1] double 0.0001 \
    run scoreboard players get $y im.motion
execute store result entity @e[type=arrow,tag=im.dart_projectile,limit=1,sort=nearest] Motion[2] double 0.0001 \
    run scoreboard players get $z im.motion
data modify entity @e[type=arrow,tag=im.dart_projectile,limit=1,sort=nearest] \
    damage set value 2.0f
data modify entity @e[type=arrow,tag=im.dart_projectile,limit=1,sort=nearest] \
    Owner set from entity @s UUID
