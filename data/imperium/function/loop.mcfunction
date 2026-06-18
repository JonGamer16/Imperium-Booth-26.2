#### LOOP FILE ####

# hunger proofing
effect give @a[scores={hunger=0..19}] saturation 1 0
# item drop proofing (for old soup dropping)
    #execute at @e[type=item] run tp @e[limit=1,type=item,distance=..1] @p
    #execute at @e[type=item] run data merge entity @e[limit=1,type=item,distance=..1] {PickupDelay:0}
# givekit engine
execute as @a[scores={givekit=1..},advancements={imperium:leave_spawn=false}] run function imperium:arena/givekit

# booth kit-selection stands
function imperium:booth/check_stands

# TODO: Optimize by turning all the below item reload functions into 1 function that checks for itemreload
# How: Replace all checks of one itemreload threshold with a single function checking for the itemreload score
#   and a tag players get for their item
# What: This will limit item refill bars to 30 damage but also save lines on the loop
# Pro Fix: To add variation in item refill, there will be 2 layers of branching functions controlling refills.
#   Here it'll have to check for a refillMeterA, refillMeterB, or refillMeterC player tag, then the
#   proper itemreload score minimum to go with it. Instead of 1 new check per new item, it'll check a limited
#   set of tags and scores, then run the branching function for that set of items.

# item reload engine
# CONFLICT NOTE: itemreload and im_abilityDealt both use custom:damage_dealt but are separate
#   objectives — resetting im_abilityDealt each tick does NOT affect itemreload accumulation.
#   Remove itemreload, item_distributor_300, and rTotem checks once ability system replaces them.
# execute as @a[scores={itemreload=300..}] in overworld run function imperium:arena/item_distributor_300
# execute as @a[scores={rTotem=1..,itemreload=600..}] in overworld run function imperium:items/totem

# ability cooldown engine (parallel system; does not interfere with itemreload above)
execute as @a[advancements={imperium:leave_spawn=true}] run function imperium:update_cooldowns

# soup drop engine (old)
    #execute at @e[type=item,nbt={Item:{id:"minecraft:beetroot_soup"}}] run function imperium:soup/beet_soup_drop
    #execute at @e[type=item,nbt={Item:{id:"minecraft:mushroom_stew"}}] run function imperium:soup/mush_soup_drop
    #execute at @e[type=item,nbt={Item:{id:"minecraft:rabbit_stew"}}] run function imperium:soup/rabbit_soup_drop

# arena mechanics
execute as @a[scores={killFlag=1..}] run function imperium:arena/kill
execute as @a[scores={onDeath=1..}] run function imperium:arena/death
execute as @a[scores={onLeave=1..}] run function imperium:arena/death
execute \
    store result score @s im_hp \
    run data get entity @s \
        Health 1000

# WIP TESTING
#execute as @e[tag=im_rot_track] run function imperium:data_fetching/get_rotation

# execute as JonGamer16 run \
#     execute store result score NearestCow im_rotation run data get entity @n[type=cow,distance=0..5] Rotation[0] 1

#execute as @a[scores={carrot_on_a_stick=1..}] run function imperium:raycaster/proxy

# Smoke Bomb (Smokey): configure freshly-thrown clouds, then emit one puff
execute \
    as @e[type=area_effect_cloud,tag=!im.smoke_bomb,nbt={potion_contents:{custom_color:1973790}}] \
    at @s \
    run function imperium:kits/smokey/smoke_init
# Smoke Bomb: grant invis + speed to Smokey players inside active clouds
execute \
    as @e[type=area_effect_cloud,tag=im.smoke_bomb] \
    at @s \
    run function imperium:kits/smokey/smoke_apply

execute \
    as @a[advancements={imperium:leave_spawn=false}] \
    unless predicate imperium:at_spawn \
    run advancement grant @s only imperium:leave_spawn
execute \
    as @a[advancements={imperium:leave_spawn=true}] \
    if predicate imperium:at_spawn \
    run advancement revoke @s only imperium:leave_spawn

scoreboard players enable @s[advancements={imperium:leave_spawn=false}] givekit

# 1-second loop (for local testing; booth uses ticking_functions at "1s")
scoreboard players add #sec im_secTimer 1
execute if score #sec im_secTimer matches 20.. run function imperium:loop_1s
execute if score #sec im_secTimer matches 20.. run scoreboard players set #sec im_secTimer 0