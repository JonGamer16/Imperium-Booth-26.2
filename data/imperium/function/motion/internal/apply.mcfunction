# Fire the local vector #lx / #ly / #lz at @s through imperium:motion_impulse.
#
# The enchantment sits on a throwaway saddle in the player's saddle slot (players never use it;
# Smithed convention reserves it for exactly this). Its location_changed effects fire on a gamemode
# change, so a spectator round-trip triggers them immediately: the first effect (internal/reset)
# deletes the saddle again, the rest apply one impulse per set bit. The saddle never survives the
# call, and no tick function is involved.

# Bits before the saddle, so the effects can never read stale bits from a previous launch.
function imperium:motion/internal/bits

item replace entity @s saddle with minecraft:saddle[\
    equippable={slot:"saddle",equip_sound:"intentionally_empty"},\
    enchantments={"imperium:motion_impulse":1}\
]

scoreboard players set #mode im.motion 0
execute if entity @s[gamemode=survival] run scoreboard players set #mode im.motion 1
execute if entity @s[gamemode=adventure] run scoreboard players set #mode im.motion 2

execute if score #mode im.motion matches 1..2 run gamemode spectator
execute if score #mode im.motion matches 1 run return run gamemode survival
execute if score #mode im.motion matches 2 run return run gamemode adventure

# Creative. As in the old library: a falling creative player round-trips through adventure
# instead of spectator.
execute if predicate imperium:motion/falling_creative store success score #mode im.motion run gamemode adventure
execute if score #mode im.motion matches 0 run gamemode spectator
return run gamemode creative
