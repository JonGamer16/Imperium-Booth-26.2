# Livvy
    # Life Steal (Livvy): bank damage dealt with the enchanted Fang, convert to soup.
    #   im_lsDealt (custom:damage_dealt) is a running total in 1/10 HP; delta = this tick.
    #   im_lsFlag was set this tick by the lifesteal enchantment while the weapon is held.
    #   100 banked = 10 HP dealt -> one empty bowl becomes a Blood Bowl soup.
    execute as @a[tag=im.kit_livvy] run scoreboard players operation \
        @s im_lsDelta = @s im_lsDealt
    execute as @a[tag=im.kit_livvy] run scoreboard players operation \
        @s im_lsDelta -= @s im_lsPrev
    execute as @a[tag=im.kit_livvy,scores={im_lsFlag=1..}] run scoreboard players operation \
        @s im_lifesteal += @s im_lsDelta
    execute as @a[tag=im.kit_livvy] run scoreboard players operation \
        @s im_lsPrev = @s im_lsDealt
    #   Repair an unseeded cost before the gate reads it: a Livvy who was already wearing the kit
    #   when this pack updated (or any path that skipped livvy/givekit) has im_lsNeed = 0, and
    #   `im_lifesteal >= 0` is ALWAYS true — that would run lifesteal_soup every tick, eating bowls
    #   and minting free soups. Cheap enough to check unconditionally, and self-heals in one tick.
    execute as @a[tag=im.kit_livvy] unless score @s im_lsNeed matches 1.. run scoreboard players \
        operation @s im_lsNeed = #lsThreshold im_lifesteal
    #   Convert — but ONLY on a tick that actually banked damage (im_lsFlag = Fang held, im_lsDelta
    #   = a hit landed). The bank alone cannot gate this: lifesteal_soup's "no bowl" branch clamps
    #   im_lifesteal to im_lsNeed, so `>=` stays true every tick once a Livvy is at cap with all of
    #   their bowls already full — and lifesteal_soup opens with a component-matching `clear`, which
    #   is far too expensive to run per-Livvy per-tick for as long as that state lasts (it is the
    #   normal state between soups). Two score checks close it to at most one attempt per hit.
    #   Requiring a hit is also what the kit advertises ("Attack to refill bowls with healing soup",
    #   livvy/booth/select): a bowl that frees up out of combat converts on the next swing.
    execute as @a[tag=im.kit_livvy,scores={im_lsFlag=1..,im_lsDelta=1..}] \
        if score @s im_lifesteal >= @s im_lsNeed \
        run function imperium:enchantments/lifesteal_soup
    #   Reset flags for next tick (the enchantment re-sets them while the weapon stays held)
    scoreboard players set @a[tag=im.kit_livvy] im_lsFlag 0