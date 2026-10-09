# RE-ARM FIRST. This function is the reward of imperium:booth/select_cliffshield, and an advancement stays
# granted once earned — so without this revoke the stand fires exactly ONCE per player and is
# then dead forever. It used to be double-wired (Summit's Interactions API called it too, via
# the summit.interactable tag on the interaction), which hid the problem; that API is gone and
# the advancement is now the only path in. Must be the FIRST line — the guards below `return`
# early, and a return before the revoke would leave the stand permanently dormant.
advancement revoke @s only imperium:booth/select_cliffshield

# Booth kit-stand click — runs AS the exact clicker, so no UUID matching is needed.
#
# NO battlegrounds assign here. imperium:kits/cliffshield/booth/select owns the
# summit.battlegrounds:api/assign_kit call, so an accepted click registers the kit exactly once.
# Calling assign here as well was the double-assign bug: every click printed
# "[Baobab Battlegrounds] You have selected ..." TWICE (once from here, once from select). It also
# fired above both guards below, so sneaking to read the lore — or a click refused by the equip
# rate-limit — still re-assigned the kit in the Battlegrounds without equipping anything.
#
# This function is DOUBLE-WIRED and that is tolerated, not accidental: Summit's Interactions API
# calls it from the stand's summit.interactable tag (see the deploy log), and
# imperium:booth/select_cliffshield calls it from player_interacted_with_entity, which is what
# makes the stand work in a bare test world with no Interactions API. Nothing revokes that
# advancement, so it fires once per player and then goes dormant. Either way both paths can land on
# the same tick; im.equip_cd below absorbs the duplicate, and with the assign call gone the
# duplicate is now silent.

# Sneak = read the lore. Never selects, never assigns.
execute if predicate imperium:sneaking run return run function imperium:kits/cliffshield/booth/lore

# Equip rate-limit: released 5t later by imperium:booth/equip_cd_clear, which this schedules
# itself. Spam-clicking a stand re-runs the whole im_givekit pipeline (clears + loot gives), so
# deny re-equips inside the window. The release deliberately does NOT live in loop_1s any more:
# that loop does not run while a player is at the stands with no session live, so the tag was set
# on a player's first ever click and never cleared — silently refusing every kit they picked after
# it and sending them into the arena on their first pick. See booth/equip_cd_clear.
execute if entity @s[tag=im.equip_cd] run return run title @s actionbar {text:"Kit swap recharging...",color:"red"}
tag @s add im.equip_cd
schedule function imperium:booth/equip_cd_clear 5t replace

function imperium:kits/cliffshield/booth/select
