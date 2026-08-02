#### 5-TICK LOOP (kit & booth interface) ####
#
# Low-frequency UI/menu work that doesn't need per-tick responsiveness. In the Summit this is
# driven by booth_definition ticking_functions ("imperium:loop_5t": "5t"), so it only ticks while a
# player is inside the booth bounds. For the local test world it's driven by the #t5 clock at
# the bottom of imperium:loop (same convention as imperium:loop_1s).
#
# Kit-stand selection is now advancement-driven (imperium:booth/select_<kit> ->
# kits/<kit>/booth/click), so it no longer polls here.

# Training dummy upkeep (this loop only ticks while someone's in the booth — exactly when
# the dummy matters).

# --- PROXIMITY-ONLY TEST VERSION -------------------------------------------------
# No auto-respawn and no booth-zone predicate: the dummy only cares about its home marker.
# Spawn it by running imperium:booth/dummy/place (marker + husk at your feet). To remove it
# for good, just kill its home marker — the "no marker within 13" rule (now in loop_1s) kills the
# husk.

    # Filters on `type=#minecraft:zombies`, never a bare `type=husk`. A dummy that reaches water
    # converts husk -> zombie -> drowned, and an exact-type selector stops matching it right when it
    # has wandered furthest — so the escapee could neither be tethered back nor killed. The vanilla
    # tag spans the whole chain, so it prunes the @e scan without that hole. See kill_husk.
    # NOTE this loop only runs while a player is in the booth; the unsupervised case (booth empty)
    # is covered by booth/dummy/empty_check, scheduled from booth/exit_booth.

    # Tether: nearest home marker is 10-13 blocks away (drifted/knocked off) -> snap to it.
    # (within 10 = home enough, leave it; beyond 13 = killed by the out-of-range rule in loop_1s.)
    execute as @e[type=#minecraft:zombies,tag=im.dummy] at @s \
        if entity @e[type=marker,tag=im.dummy_home,distance=..13] \
        unless entity @e[type=marker,tag=im.dummy_home,distance=..10] \
        run tp @s @n[type=marker,tag=im.dummy_home]

    # The matching "no marker within 13 -> kill it" rule lives in loop_1s (same booth-scoped
    # ticking_functions, a quarter of the scans). Its 13 must stay in step with the tether's outer
    # bound above, or a dummy in the gap would neither snap back nor die.

# The Battlegrounds teleport pads used to live here. They're advancement-driven now
# (imperium:booth/warp_from_{kitroom,shulkerbox}) — this loop only ticks while a player is inside
# the booth bounding boxes, and the kit-room return pad sits outside all of them.
