# Crosshair tracker tick — runs as the holder every tick from the Focus Attack (Rastus) and
# Charge Attack (Levent) enchants' minecraft:tick effect, so it only fires while the enchanted
# weapon is actually in the mainhand ("actively using" the kit). Summons this player's tracker
# interaction on the first tick, then pins it exactly to the crosshair (eye anchor, 3 blocks out)
# every tick after. aim_free kills it on death / round end / kit swap.
execute if entity @s[tag=!im.aim_bound] run function imperium:enchantments/aim_bind

# Pair lookup mirrors bomb_detonate: stash my id in a fake player, then move only MY interaction.
scoreboard players operation #me im_aimId = @s im_aimId
execute \
    at @s \
    anchored eyes \
    positioned ^ ^-0.001 ^3 \
    as @e[type=interaction,tag=im.aim] \
    if score @s im_aimId = #me im_aimId \
    run tp @s ~ ~ ~
