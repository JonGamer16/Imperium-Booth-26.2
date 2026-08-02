# Sticker 3 (Champion of the Arena): grant to the round winner (@s = rank 1). #earlyEnd flags how
# the round ended: 0 = interval time-out, 1 = elimination (opponents ran out of lives), 2 = walkover
# (opponents left the arena early). A walkover win only counts with >=5 gold — proof the survivor
# actually fought — while a genuine combat/time win grants outright. Advancement is Summit-generated;
# granting is idempotent (no-op if already held, or absent in a local test world).
execute unless score #earlyEnd im.temp matches 2 run advancement grant @s only summit.sticker_book:imperium/win_fight
execute if score #earlyEnd im.temp matches 2 if score @s im_gold matches 5.. run advancement grant @s only summit.sticker_book:imperium/win_fight