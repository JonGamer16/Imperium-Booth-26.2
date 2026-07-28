# Constants: one objective, fake players named "#<value>" (e.g. #100 holds 100).
# Only needed for arithmetic (/=, *=, %=, min/max clamp) where a command can't take a
# literal. For plain comparisons prefer `execute if score ... matches <range>` instead of
# comparing against one of these. Add a new value here when an operation first needs it.
scoreboard objectives add imperium.const dummy
scoreboard players set #0 imperium.const 0
scoreboard players set #1 imperium.const 1
scoreboard players set #2 imperium.const 2
scoreboard players set #3 imperium.const 3
scoreboard players set #10 imperium.const 10
scoreboard players set #100 imperium.const 100
scoreboard players set #250 imperium.const 250
