# RE-ARM FIRST. This function is the reward of imperium:booth/random, and an advancement stays
# granted once earned — so without this revoke the stand fires exactly ONCE per player and is
# then dead forever. It used to be double-wired (Summit's Interactions API called it too, via
# the summit.interactable tag on the interaction), which hid the problem; that API is gone and
# the advancement is now the only path in. Must be the FIRST line — the guards below `return`
# early, and a return before the revoke would leave the stand permanently dormant.
advancement revoke @s only imperium:booth/random

# Random-kit stand click — Summit Interactions API (summon's on_right_click), runs as the
# exact clicker.
# re-runs the whole im_givekit pipeline (clears + loot gives), so deny re-equips inside the window.
function imperium:booth/random/select
