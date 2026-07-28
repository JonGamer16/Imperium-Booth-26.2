# @s ran out of lives. Announce it, ship them back to the kit room, and close out their round
# (end_fighter = post-game stats + drop im.fighting/no_regen + clear the kit). Called from
# arena/on_death when im_lives hits 0.
tellraw @a[tag=summit.battlegrounds.player] [{"text":"ELIMINATED - ","color":"red"},{"selector":"@s","color":"red"}]

tp @s[gamemode=!creative] -78 87 -8 -90 0

function imperium:summit/end_fighter

# Round ends once only one fighter with lives is left (every im.fighting player has lives by
# construction — they're untagged the moment they hit 0 above). <=1 also covers a simultaneous
# double-elimination emptying the arena.
execute store result score #alive im.temp if entity @a[tag=im.fighting]
# #earlyEnd=1 tells resolve_match this ended by last-man-standing: crown the survivor first, THEN
# rank the rest (incl. everyone eliminated) by gold.
execute if score #alive im.temp matches ..1 run scoreboard players set #earlyEnd im.temp 1
execute if score #alive im.temp matches ..1 run function imperium:arena/round_over
