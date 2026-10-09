# Booth-empty sweep — take the training dummy down once the last player is out.
#
# WHY: the dummy is the only booth entity that MOVES on its own, and loop_5t (which holds its
# tether to the im.dummy_home marker) stops running the moment the safe zone is empty — that is the
# idle gate at the top of imperium:tick. So a dummy that got knocked loose right as the last guest walked out is completely
# unsupervised: it can path out of the bounding boxes, and one that reaches the cave river below
# converts husk -> zombie -> drowned. That conversion is what makes it unrecoverable, not the
# wandering: every cleanup selector we had was type-scoped to husk, so the drowned matched nothing
# and stayed out there permanently, wearing a full Mummy kit and a Dark Claymore. Killing the dummy
# when the booth empties deletes the unsupervised window instead of trying to chase its symptoms.
#
# Scheduled 10t out by booth/exit_booth rather than run inline: exit_booth runs as part of the same
# falling edge that clears im.in_safe_zone, so an inline check could still see the leaving player
# inside and skip the kill. The delay lets the latch settle.
execute if entity @a[tag=im.in_safe_zone] run return 0

# Mob only — the im.dummy_home marker stays put, so the next visitor's interaction toggle puts a
# fresh dummy right back.
function imperium:booth/dummy/kill_husk
