# Tear down the Gold Rush standings billboard. Every line carries the shared im.gold_board tag, so
# one kill clears the whole board however many lines it has.
#
# Called from board_spawn (making a respawn idempotent), from summit/booth_inactive (our session
# ended — the arena is about to become another booth's, and our board must not float in it), and
# from the #summit.booth:imperium/entities/kill teardown hook.
#
# im.gold_board_text is the pre-split single-entity board; killing it too clears any leftover from
# a world that ran the old version. Safe to drop once no live world has one.
kill @e[type=text_display,tag=im.gold_board]
kill @e[type=text_display,tag=im.gold_board_text]
kill @e[type=marker,tag=im.gold_board]
