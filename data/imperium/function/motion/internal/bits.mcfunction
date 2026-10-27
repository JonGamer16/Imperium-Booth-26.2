# Split #lx / #ly / #lz into the per-bit flags #<axis>.<n> im.motion that imperium:motion_impulse
# reads. 18-bit two's complement: bit 17 is worth -131072, bits 16..0 are worth +2^n. Clamps
# first, so the range is -131072..131071 (x 0.0001 b/t). Consumes #l* (they end at 0).
#
# Each flag is written by a store whose LAST subcommand is the `if`, so it always stores 1 or 0.
# Do NOT fold the subtraction into the same line (`store success ... if ... run remove`): when
# the `if` fails mid-chain nothing is stored, a flag set by an earlier launch stays 1 forever,
# and every later launch carries it — that is how a stuck bit 17 (-13 b/t) pinned players down.
# GENERATED alongside enchantment/motion_impulse.json; keep BITS in sync if you regenerate.

scoreboard players operation #lx im.motion < #max im.motion
scoreboard players operation #lx im.motion > #min im.motion
execute store result score #x.17 im.motion if score #lx im.motion matches ..-1
execute if score #x.17 im.motion matches 1 run scoreboard players add #lx im.motion 131072
execute store result score #x.16 im.motion if score #lx im.motion matches 65536..
execute if score #x.16 im.motion matches 1 run scoreboard players remove #lx im.motion 65536
execute store result score #x.15 im.motion if score #lx im.motion matches 32768..
execute if score #x.15 im.motion matches 1 run scoreboard players remove #lx im.motion 32768
execute store result score #x.14 im.motion if score #lx im.motion matches 16384..
execute if score #x.14 im.motion matches 1 run scoreboard players remove #lx im.motion 16384
execute store result score #x.13 im.motion if score #lx im.motion matches 8192..
execute if score #x.13 im.motion matches 1 run scoreboard players remove #lx im.motion 8192
execute store result score #x.12 im.motion if score #lx im.motion matches 4096..
execute if score #x.12 im.motion matches 1 run scoreboard players remove #lx im.motion 4096
execute store result score #x.11 im.motion if score #lx im.motion matches 2048..
execute if score #x.11 im.motion matches 1 run scoreboard players remove #lx im.motion 2048
execute store result score #x.10 im.motion if score #lx im.motion matches 1024..
execute if score #x.10 im.motion matches 1 run scoreboard players remove #lx im.motion 1024
execute store result score #x.9 im.motion if score #lx im.motion matches 512..
execute if score #x.9 im.motion matches 1 run scoreboard players remove #lx im.motion 512
execute store result score #x.8 im.motion if score #lx im.motion matches 256..
execute if score #x.8 im.motion matches 1 run scoreboard players remove #lx im.motion 256
execute store result score #x.7 im.motion if score #lx im.motion matches 128..
execute if score #x.7 im.motion matches 1 run scoreboard players remove #lx im.motion 128
execute store result score #x.6 im.motion if score #lx im.motion matches 64..
execute if score #x.6 im.motion matches 1 run scoreboard players remove #lx im.motion 64
execute store result score #x.5 im.motion if score #lx im.motion matches 32..
execute if score #x.5 im.motion matches 1 run scoreboard players remove #lx im.motion 32
execute store result score #x.4 im.motion if score #lx im.motion matches 16..
execute if score #x.4 im.motion matches 1 run scoreboard players remove #lx im.motion 16
execute store result score #x.3 im.motion if score #lx im.motion matches 8..
execute if score #x.3 im.motion matches 1 run scoreboard players remove #lx im.motion 8
execute store result score #x.2 im.motion if score #lx im.motion matches 4..
execute if score #x.2 im.motion matches 1 run scoreboard players remove #lx im.motion 4
execute store result score #x.1 im.motion if score #lx im.motion matches 2..
execute if score #x.1 im.motion matches 1 run scoreboard players remove #lx im.motion 2
scoreboard players operation #x.0 im.motion = #lx im.motion
scoreboard players set #lx im.motion 0

scoreboard players operation #ly im.motion < #max im.motion
scoreboard players operation #ly im.motion > #min im.motion
execute store result score #y.17 im.motion if score #ly im.motion matches ..-1
execute if score #y.17 im.motion matches 1 run scoreboard players add #ly im.motion 131072
execute store result score #y.16 im.motion if score #ly im.motion matches 65536..
execute if score #y.16 im.motion matches 1 run scoreboard players remove #ly im.motion 65536
execute store result score #y.15 im.motion if score #ly im.motion matches 32768..
execute if score #y.15 im.motion matches 1 run scoreboard players remove #ly im.motion 32768
execute store result score #y.14 im.motion if score #ly im.motion matches 16384..
execute if score #y.14 im.motion matches 1 run scoreboard players remove #ly im.motion 16384
execute store result score #y.13 im.motion if score #ly im.motion matches 8192..
execute if score #y.13 im.motion matches 1 run scoreboard players remove #ly im.motion 8192
execute store result score #y.12 im.motion if score #ly im.motion matches 4096..
execute if score #y.12 im.motion matches 1 run scoreboard players remove #ly im.motion 4096
execute store result score #y.11 im.motion if score #ly im.motion matches 2048..
execute if score #y.11 im.motion matches 1 run scoreboard players remove #ly im.motion 2048
execute store result score #y.10 im.motion if score #ly im.motion matches 1024..
execute if score #y.10 im.motion matches 1 run scoreboard players remove #ly im.motion 1024
execute store result score #y.9 im.motion if score #ly im.motion matches 512..
execute if score #y.9 im.motion matches 1 run scoreboard players remove #ly im.motion 512
execute store result score #y.8 im.motion if score #ly im.motion matches 256..
execute if score #y.8 im.motion matches 1 run scoreboard players remove #ly im.motion 256
execute store result score #y.7 im.motion if score #ly im.motion matches 128..
execute if score #y.7 im.motion matches 1 run scoreboard players remove #ly im.motion 128
execute store result score #y.6 im.motion if score #ly im.motion matches 64..
execute if score #y.6 im.motion matches 1 run scoreboard players remove #ly im.motion 64
execute store result score #y.5 im.motion if score #ly im.motion matches 32..
execute if score #y.5 im.motion matches 1 run scoreboard players remove #ly im.motion 32
execute store result score #y.4 im.motion if score #ly im.motion matches 16..
execute if score #y.4 im.motion matches 1 run scoreboard players remove #ly im.motion 16
execute store result score #y.3 im.motion if score #ly im.motion matches 8..
execute if score #y.3 im.motion matches 1 run scoreboard players remove #ly im.motion 8
execute store result score #y.2 im.motion if score #ly im.motion matches 4..
execute if score #y.2 im.motion matches 1 run scoreboard players remove #ly im.motion 4
execute store result score #y.1 im.motion if score #ly im.motion matches 2..
execute if score #y.1 im.motion matches 1 run scoreboard players remove #ly im.motion 2
scoreboard players operation #y.0 im.motion = #ly im.motion
scoreboard players set #ly im.motion 0

scoreboard players operation #lz im.motion < #max im.motion
scoreboard players operation #lz im.motion > #min im.motion
execute store result score #z.17 im.motion if score #lz im.motion matches ..-1
execute if score #z.17 im.motion matches 1 run scoreboard players add #lz im.motion 131072
execute store result score #z.16 im.motion if score #lz im.motion matches 65536..
execute if score #z.16 im.motion matches 1 run scoreboard players remove #lz im.motion 65536
execute store result score #z.15 im.motion if score #lz im.motion matches 32768..
execute if score #z.15 im.motion matches 1 run scoreboard players remove #lz im.motion 32768
execute store result score #z.14 im.motion if score #lz im.motion matches 16384..
execute if score #z.14 im.motion matches 1 run scoreboard players remove #lz im.motion 16384
execute store result score #z.13 im.motion if score #lz im.motion matches 8192..
execute if score #z.13 im.motion matches 1 run scoreboard players remove #lz im.motion 8192
execute store result score #z.12 im.motion if score #lz im.motion matches 4096..
execute if score #z.12 im.motion matches 1 run scoreboard players remove #lz im.motion 4096
execute store result score #z.11 im.motion if score #lz im.motion matches 2048..
execute if score #z.11 im.motion matches 1 run scoreboard players remove #lz im.motion 2048
execute store result score #z.10 im.motion if score #lz im.motion matches 1024..
execute if score #z.10 im.motion matches 1 run scoreboard players remove #lz im.motion 1024
execute store result score #z.9 im.motion if score #lz im.motion matches 512..
execute if score #z.9 im.motion matches 1 run scoreboard players remove #lz im.motion 512
execute store result score #z.8 im.motion if score #lz im.motion matches 256..
execute if score #z.8 im.motion matches 1 run scoreboard players remove #lz im.motion 256
execute store result score #z.7 im.motion if score #lz im.motion matches 128..
execute if score #z.7 im.motion matches 1 run scoreboard players remove #lz im.motion 128
execute store result score #z.6 im.motion if score #lz im.motion matches 64..
execute if score #z.6 im.motion matches 1 run scoreboard players remove #lz im.motion 64
execute store result score #z.5 im.motion if score #lz im.motion matches 32..
execute if score #z.5 im.motion matches 1 run scoreboard players remove #lz im.motion 32
execute store result score #z.4 im.motion if score #lz im.motion matches 16..
execute if score #z.4 im.motion matches 1 run scoreboard players remove #lz im.motion 16
execute store result score #z.3 im.motion if score #lz im.motion matches 8..
execute if score #z.3 im.motion matches 1 run scoreboard players remove #lz im.motion 8
execute store result score #z.2 im.motion if score #lz im.motion matches 4..
execute if score #z.2 im.motion matches 1 run scoreboard players remove #lz im.motion 4
execute store result score #z.1 im.motion if score #lz im.motion matches 2..
execute if score #z.1 im.motion matches 1 run scoreboard players remove #lz im.motion 2
scoreboard players operation #z.0 im.motion = #lz im.motion
scoreboard players set #lz im.motion 0
