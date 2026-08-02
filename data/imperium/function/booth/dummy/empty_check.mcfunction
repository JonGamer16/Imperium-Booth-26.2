# Booth-empty sweep — take the training dummy down once the last player is out.
#
# WHY: the dummy is the only booth entity that MOVES on its own, and loop_5t (which holds its
# tether to the im.dummy_home marker) is a booth ticking_function — it stops the moment the booth
# is empty. So a dummy that got knocked loose right as the last guest walked out is completely
# unsupervised: it can path out of the bounding boxes, and one that reaches the cave river below
# converts husk -> zombie -> drowned. That conversion is what makes it unrecoverable, not the
# wandering: every cleanup selector we had was type-scoped to husk, so the drowned matched nothing
# and stayed out there permanently, wearing a full Mummy kit and a Dark Claymore. Killing the dummy
# when the booth empties deletes the unsupervised window instead of trying to chase its symptoms.
#
# Scheduled 10t out by booth/exit_booth rather than run inline: Summit's summit.in_booth.imperium
# bookkeeping for the leaving player may not have landed yet when on_player_exit fires, so an inline
# check could still see them inside and skip the kill.
execute if entity @a[tag=summit.in_booth.imperium] run return 0

# Mob only — the im.dummy_home marker is summit.static and stays put, so the next visitor's
# interaction toggle (or the #entities/summon hook on booth load) puts a fresh dummy right back.
function imperium:booth/dummy/kill_husk
