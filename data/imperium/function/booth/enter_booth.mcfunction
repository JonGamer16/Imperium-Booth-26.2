title @s subtitle {color:"gold",text:"by JonGamer16"}
title @s title {color:"gold",text:"Imperium Mundi"}

# Sticker 1 (New Challenger Approaching): granted on entering the booth. The advancement is generated
# by Summit from the booth_definition sticker_book entry; we only grant it (idempotent, so re-entry
# is fine). Won't exist in a local test world without the Summit datapack — the command just no-ops.
advancement grant @s only summit.sticker_book:imperium/enter_booth
