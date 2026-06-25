scoreboard players set @e[type=#imperium:human,scores={killFlag=1..,killDamage=200..}] onKill 1
scoreboard players set @e[type=#imperium:human,scores={killFlag=1..,killDamage=..199}] killFlag 0

# Per-kit healing refresh (legacy global heals + trident/goldarmor refills removed — tag legacy-full)
execute as @e[type=#imperium:human,scores={onKill=1},tag=im.kit_cliffshield] run function imperium:kits/cliffshield/on_kill
execute as @e[type=#imperium:human,scores={onKill=1},tag=im.kit_meowdy] run function imperium:kits/meowdy/on_kill
execute as @e[type=#imperium:human,scores={onKill=1},tag=im.kit_livvy] run function imperium:kits/livvy/on_kill
execute as @e[type=#imperium:human,scores={onKill=1},tag=im.kit_mummy] run function imperium:kits/mummy/on_kill
execute as @e[type=#imperium:human,scores={onKill=1},tag=im.kit_levent] run function imperium:kits/levent/on_kill
execute as @e[type=#imperium:human,scores={onKill=1},tag=im.kit_rastus] run function imperium:kits/rastus/on_kill
execute as @e[type=#imperium:human,scores={onKill=1},tag=im.kit_smokey] run function imperium:kits/smokey/on_kill

scoreboard players set @e[type=#imperium:human,scores={onKill=1}] killDamage 0
scoreboard players set @e[type=#imperium:human,scores={onKill=1}] killFlag 0
scoreboard players set @e[type=#imperium:human,scores={onKill=1}] onKill 0
