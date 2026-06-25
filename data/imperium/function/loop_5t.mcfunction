#### 5-TICK LOOP (kit & booth interface) ####
#
# Low-frequency UI/menu work that doesn't need per-tick responsiveness. In the Summit this is
# driven by booth_definition ticking_functions ("imperium:loop_5t": "5t"), so it only ticks while a
# player is inside the booth bounds. For the local test world it's driven by the #t5 clock at
# the bottom of imperium:loop (same convention as imperium:loop_1s).
#
# Kit-stand selection is now advancement-driven (imperium:booth/select_<kit> ->
# kits/<kit>/booth/click), so it no longer polls here. This loop is kept as the home for future
# low-frequency booth UI (training-dummy reset, balloon-vendor cooldown, etc.). Currently empty.
