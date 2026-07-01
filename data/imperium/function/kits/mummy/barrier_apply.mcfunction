# Project the current im_energy onto the absorption barrier: set the max_absorption cap to
# energy*Scale/100 HP and flash the hearts to match (see barrier_macro). Shared by barrier_raise and
# by any mid-block energy change (e.g. a Golem Throw spend via golem_after) so the shield always
# tracks the meter. hp is stored as an INT — a float's "20.0f" SNBT breaks the macro's attribute add.
scoreboard players operation #absX im.temp = @s im_energy
scoreboard players operation #absX im.temp *= #MummyBarrierScale im.param
execute store result storage imperium:mummy hp int 0.01 run scoreboard players get #absX im.temp
function imperium:kits/mummy/barrier_macro with storage imperium:mummy
