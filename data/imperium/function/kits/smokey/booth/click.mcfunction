# Booth kit-stand click — advancement-driven (fires from imperium:booth/select_smokey when a
# player right-clicks the smokey stand's interaction entity). Runs AS the exact clicker, so no
# UUID matching is needed. Re-arm the advancement, then route by sneak state.
advancement revoke @s only imperium:booth/select_smokey
execute if predicate imperium:sneaking run return run function imperium:kits/smokey/booth/lore
# Equip rate-limit: im.equip_cd is cleared every second by loop_1s. Spam-clicking a stand
# re-runs the whole givekit pipeline (clears + loot gives), so deny re-equips inside the window.
execute if entity @s[tag=im.equip_cd] run return run title @s actionbar {text:"Kit swap recharging...",color:"red"}
tag @s add im.equip_cd
function imperium:kits/smokey/booth/select
