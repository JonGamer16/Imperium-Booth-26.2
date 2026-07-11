# ===== Global defaults =====
#   Default item cooldown length (damage units). Abilities pass base:0 to inherit this.
scoreboard players set #GlobalDefault im.dmg 500
#   Default stockpile %: how much of a cooldown may pre-charge while frozen.
#   Abilities pass stock:-1 to inherit this. floor = base*(100-stock)/100.
scoreboard players set #GlobalStock im.dmg 50

# ===== Per-ability cooldowns =====
#   set_cd {kit, slot, base, stock}:  base 0 = global default, stock -1 = global default.
#   Slot letters follow the cd*_* functions, not any stale labels.

# Cliffshield: A Shield, B Arrows, C Rush Potion
function imperium:abilities/set_cd {kit:"Cliffshield",slot:"A",base:0,stock:-1}
function imperium:abilities/set_cd {kit:"Cliffshield",slot:"B",base:250,stock:-1}
function imperium:abilities/set_cd {kit:"Cliffshield",slot:"C",base:250,stock:-1}

# Levent: A Levitation Arrows, B Shield  (C empty)
function imperium:abilities/set_cd {kit:"Levent",slot:"A",base:150,stock:-1}
function imperium:abilities/set_cd {kit:"Levent",slot:"B",base:300,stock:-1}

# Livvy: A Leap, B Web, C Acid Potion
function imperium:abilities/set_cd {kit:"Livvy",slot:"A",base:150,stock:-1}
function imperium:abilities/set_cd {kit:"Livvy",slot:"B",base:150,stock:-1}
function imperium:abilities/set_cd {kit:"Livvy",slot:"C",base:150,stock:-1}

# Meowdy: A Leap, B Arrows  (C empty)
function imperium:abilities/set_cd {kit:"Meowdy",slot:"A",base:100,stock:-1}
function imperium:abilities/set_cd {kit:"Meowdy",slot:"B",base:100,stock:90}

# Mummy: A Golem Throw, B Grapple Rod  (C empty)
function imperium:abilities/set_cd {kit:"Mummy",slot:"A",base:100,stock:-1}
function imperium:abilities/set_cd {kit:"Mummy",slot:"B",base:100,stock:-1}

# Rastus: A Buckler Shield, B Strike/Parry, C Air Dodge charges
#   base 50 = one dash back per 5.0 HP of net damage (dealt + taken, engine standard).
function imperium:abilities/set_cd {kit:"Rastus",slot:"A",base:400,stock:-1}
function imperium:abilities/set_cd {kit:"Rastus",slot:"B",base:50,stock:-1}
function imperium:abilities/set_cd {kit:"Rastus",slot:"C",base:50,stock:-1}

# Smokey: A Boost Rod, B Marking Dart, C Smoke Bomb
function imperium:abilities/set_cd {kit:"Smokey",slot:"A",base:400,stock:80}
function imperium:abilities/set_cd {kit:"Smokey",slot:"B",base:200,stock:-1}
function imperium:abilities/set_cd {kit:"Smokey",slot:"C",base:200,stock:-1}

# ===== Charges per refill cycle (im_cdMax*) =====
# A slot listed here freezes its cooldown until all its charges are spent.
# Slots with no max keep 0 charges and fall back to the old always-counting cooldown.
# Livvy slot A = Leap feather
scoreboard players set #Livvy im_cdMaxA 1
# Livvy slot B = Throwable Web: 3 charges, count-based (tracked off her real web stack)
scoreboard players set #Livvy im_cdMaxB 3
# Meowdy slot A = Leap feather
scoreboard players set #Meowdy im_cdMaxA 1
# Smokey slot B = Marking Dart
scoreboard players set #Smokey im_cdMaxB 1
# Rastus slot C = Air Dodge: 5 stored dashes; air_dodge consumes, cd3_dodge refills one at a time.
scoreboard players set #Rastus im_cdMaxC 5
# Meowdy slot B = Arrows: count-based & multi-charge -> max is derived from the actual
# arrow stack at givekit (see meowdy/givekit), so no #Kit constant is set here.
