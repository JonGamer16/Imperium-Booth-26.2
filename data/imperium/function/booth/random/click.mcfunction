# Random-kit stand click — advancement-driven (imperium:booth/select_random), runs as the
# exact clicker. Sneak = describe, click = roll.
advancement revoke @s only imperium:booth/select_random
execute if predicate imperium:sneaking run return run tellraw @s {text:" Random Kit — try your luck with one of the seven fighters.",color:"gray"}
# Equip rate-limit: im.equip_cd is cleared every second by loop_1s. Spam-clicking a stand
# re-runs the whole givekit pipeline (clears + loot gives), so deny re-equips inside the window.
execute if entity @s[tag=im.equip_cd] run return run title @s actionbar {text:"Kit swap recharging...",color:"red"}
tag @s add im.equip_cd
function imperium:booth/random/select
