# Sticker 2 (Historian): grant once the player has read all seven fighters' lore. Called at the end
# of each kit's booth/lore after it adds that kit's im.lore_* tag. The advancement is Summit-
# generated; granting is idempotent. NOTE: the lore tags live on the player entity and are NOT
# shard-synced, so all seven must be read on one shard — but the granted advancement IS synced.
execute if entity @s[tag=im.lore_cliffshield,tag=im.lore_levent,tag=im.lore_livvy,tag=im.lore_meowdy,tag=im.lore_mummy,tag=im.lore_rastus,tag=im.lore_smokey] run advancement grant @s only summit.sticker_book:imperium/read_lore
