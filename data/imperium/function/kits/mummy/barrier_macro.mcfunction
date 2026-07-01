# Set the player's absorption hearts to $(hp) HP. Called with {hp:<int>} (an int — a float's SNBT
# "20.0f" suffix breaks the attribute value). /data can't write a player's AbsorptionAmount, so:
#   1) set the max_absorption cap to hp, 2) flash the absorption effect to fill the hearts, 3) clear
#   it — the fill then clamps down to and persists at our cap. Amp 4 fills 20 HP; raise it if hp can
#   exceed 20 (EnergyMax*Scale/100).
attribute @s max_absorption modifier remove imperium:barrier
$attribute @s max_absorption modifier add imperium:barrier $(hp) add_value
effect give @s absorption 1 4 true
effect clear @s absorption