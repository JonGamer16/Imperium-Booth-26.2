# Booth kit-stand click — advancement-driven (fires from imperium:booth/select_livvy when a
# player right-clicks the livvy stand's interaction entity). Runs AS the exact clicker, so no
# UUID matching is needed. Re-arm the advancement, then route by sneak state.
function imperium:kits/livvy/booth/assign
execute if predicate imperium:sneaking run return run function imperium:kits/livvy/booth/lore
# Equip rate-limit: im.equip_cd is cleared every second by loop_1s. Spam-clicking a stand
# re-runs the whole im_givekit pipeline (clears + loot gives), so deny re-equips inside the window.
execute if entity @s[tag=im.equip_cd] run return run title @s actionbar {text:"Kit swap recharging...",color:"red"}
tag @s add im.equip_cd
function imperium:kits/livvy/booth/select
