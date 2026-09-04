# high_jump_off - remove the low-gravity modifier and clear the flag
attribute @s minecraft:gravity modifier remove imperium:high_jump

# LEGACY SWEEP — safe to delete once every player who was online before the rename has been
# through a kit clear. The id used to be the bare `im_high_jump` (= `minecraft:im_high_jump`), and
# a rename alone would strand that modifier: the line above no longer matches it, so anyone who
# logged off mid-jump would keep -80% gravity forever, everywhere on the server. Removing an
# absent modifier is a silent no-op, so this costs nothing in the meantime.
attribute @s minecraft:gravity modifier remove im_high_jump

scoreboard players set @s im_high_jump 0
