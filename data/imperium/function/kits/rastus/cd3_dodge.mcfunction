# Incremental Air Dodge recharge: bank ONE dash toward the 5-charge stock, then restart the
# cooldown. No item to hand back — the charge count itself is the resource; air_dodge spends it.
# The freeze (im_cdUsesC >= im_cdMaxC) stops the cooldown from re-reaching 0 past 5. Mirror of
# Livvy's cd2_web.
# Hard cap: the freeze clamps at the START of an engine pass, so a refill that leaves
# im_abilityCdC still <= 0 (big overshoot hit) would re-dispatch within the SAME pass
# (update_cooldowns fires kit_dispatch once per slot at <= 0) and overfill without this.
execute if score @s im_cdUsesC >= @s im_cdMaxC run return 0
scoreboard players add @s im_cdUsesC 1
scoreboard players operation @s im_abilityCdC += #Rastus im_abilityCdC

title @s actionbar [{"text":"⇢ Dash recharged (","color":"aqua"},{"score":{"name":"@s","objective":"im_cdUsesC"},"color":"aqua"},{"text":"/","color":"aqua"},{"score":{"name":"#Rastus","objective":"im_cdMaxC"},"color":"aqua"},{"text":")","color":"aqua"}]
playsound minecraft:block.note_block.chime player @s ~ ~ ~ 0.6 1.8
