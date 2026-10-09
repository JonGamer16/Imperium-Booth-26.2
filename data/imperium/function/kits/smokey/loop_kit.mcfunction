# Smokey per-tick scans that only matter while a Smokey is online — called once via
# `if entity @a[tag=im.kit_smokey]` from imperium:loop. (The Mark TIMER on victims persists after
# Smokey leaves, so mark_tick stays out in the main loop.)

# Grappling Rod: track cast bobbers and launch the angler on reel-in.
function imperium:kits/smokey/grapple_track

# Smoke Bomb: configure freshly-thrown clouds, then grant invis + speed to Smokey players inside.
# The in_bounds gate that used to sit ahead of `nbt=` here is GONE. It existed to reject ~70 other
# booths' same-type clouds on the Summit server before paying for the NBT read, and to stop a smoke
# bomb being set up outside the build. Standalone there are no foreign booths, and the ability gate
# is now "is holding a kit" rather than "is inside the build" — so a bounds test would only mean
# Smokey's bomb silently failed to arm anywhere outside the pagoda.
#
# `tag=!im.smoke_bomb` stays and is now the only guard: it excludes clouds already configured, so the
# potion-contents read runs once per cloud rather than every tick for the cloud's whole life.
execute as @e[type=area_effect_cloud,tag=!im.smoke_bomb,nbt={potion_contents:{custom_color:1973790}}] at @s run function imperium:kits/smokey/smoke_init
execute as @e[type=area_effect_cloud,tag=im.smoke_bomb] at @s run function imperium:kits/smokey/smoke_apply

# Marking Dart: convert any player carrying the dart's Bad Omen signal to the tracked im.marked tag.
execute as @a[predicate=imperium:ability_zone] if predicate imperium:has_bad_omen run function imperium:kits/smokey/mark_apply

# Offhand Attack timer: tick down each online Smokey's per-player cooldown.
# loop_kit runs once (server context, no @s), so we must iterate the players explicitly.
execute \
    as @a[tag=im.kit_smokey] \
    if score @s im_offhandCd matches 1.. \
    run scoreboard players remove @s im_offhandCd 1