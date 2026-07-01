# Spend energy for a Mummy ability. Macro input: {cost:<n>} (pass the ability's #Mummy*Cost value).
#   Sets #spent im.temp = 1 and deducts cost when @s has at least cost banked; otherwise 0 and no
#   deduct. Callers gate the ability on `if score #spent im.temp matches 1` immediately after this.
$execute store success score #spent im.temp if score @s im_energy matches $(cost)..
$execute if score #spent im.temp matches 1 run scoreboard players remove @s im_energy $(cost)
