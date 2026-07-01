# Energy Barrier (runs per tick for each Mummy via energy_tick). Hold sneak to project the energy
# pool as absorption hearts; incoming damage eats the hearts and — via the hold sync — the meter.
# Releasing sneak refunds whatever's left. Energy and absorption are one pool, two views.

# HOLD: barrier already up and still being held -> mirror the live absorption back into energy so the
#   meter drains as hits land. Read-only (AbsorptionAmount is only written on raise), so vanilla's
#   "absorption depletes first" does the damage math for us. Must run before the raise check.
execute \
    if entity @s[tag=im.barrier_up,predicate=imperium:sneaking] \
    run function imperium:kits/mummy/barrier_sync

# RAISE: sneaking with enough banked and no barrier yet -> snapshot energy into absorption hearts.
execute \
    if entity @s[tag=!im.barrier_up,predicate=imperium:sneaking] \
    if score @s im_energy >= #MummyBarrierMin im.param \
    run function imperium:kits/mummy/barrier_raise

# LOWER: barrier up but no longer held, or drained to empty -> drop the hearts, keep the energy.
execute \
    if entity @s[tag=im.barrier_up] \
    unless entity @s[predicate=imperium:sneaking] \
    run function imperium:kits/mummy/barrier_lower
execute \
    if entity @s[tag=im.barrier_up] \
    if score @s im_energy matches ..0 \
    run function imperium:kits/mummy/barrier_lower