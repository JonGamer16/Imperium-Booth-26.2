# Per-tick Mummy energy upkeep — called as each im.kit_mummy from the main loop. Bank any consumed
# Energy Crystals, run the Energy Barrier (which may drain the meter), then repaint the action-bar
# readout so it reflects this tick's value.
function imperium:kits/mummy/crystal_consume
function imperium:kits/mummy/barrier_tick
function imperium:kits/mummy/energy_hud
