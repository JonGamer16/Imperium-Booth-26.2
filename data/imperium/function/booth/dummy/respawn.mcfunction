# Ensure exactly ONE training dummy: a mummy-armored husk guests can spar with (booth players carry
# summit.no_regen, so its hits land and healing items get real practice). Regeneration 10 (hidden)
# tops it up between visitors; the 5t loop tethers it to its im.dummy_home marker. follow_range 4
# keeps it from wandering after players. CustomNameVisible:0b makes "Training Dummy" a hover-only
# mob name (look at it to read it) instead of a plate floating over the booth through walls;
# name_tag_distance caps even that at 16 blocks (the attribute is in BLOCKS off a 64 default, not
# the 0-1 multiplier the text displays' view_range uses). summit.dynamic: it moves and takes
# damage, so it's summoned via #entities/summon and must never ride the schematic.
#
# armor base 0: a husk ships with 2 natural armor on top of whatever it wears, which would put the
# dummy at 17 armor while a real Mummy player sits at 15 (helmet only — players have no base armor).
# Zeroing the base makes every damage-indicator reading match what the same hit does to a live
# Mummy. If you ever retune mummy/givekit's head armor, this stays correct automatically.
#
# Spawns on the im.dummy_home marker NEAREST the canonical spot (-78.5 87 12.5) — the ONE place
# that coord lives — so a stray extra marker never pulls it off-station. Kills any existing dummy
# husk first, so this is idempotent: the manual "spawn" command, the #entities/summon hook, and the
# interaction toggle all converge on a single husk. No marker within reach -> nothing spawns.
# Tag-only kill, no `type=husk` — a converted (drowned) predecessor must not survive a respawn and
# leave two dummies fighting over one marker. See kill_husk.
kill @e[tag=im.dummy]

execute positioned -78.5 87.0 12.5 as @n[type=marker,tag=im.dummy_home] at @s run summon minecraft:husk ~ ~ ~ \
    {   Tags:["im.dummy","im.dummy_new","summit.booth_entity.imperium","summit.dynamic"],\
        PersistenceRequired:1b,\
        CanPickUpLoot:0b,\
        CustomName:{text:"Training Dummy",color:"gold",italic:false},\
        CustomNameVisible:0b,\
        drop_chances:{mainhand:0.0f,head:0.0f,chest:0.0f,legs:0.0f,feet:0.0f},\
        DeathLootTable:"minecraft:empty",\
        Health:200.0f,\
        attributes:[{id:"minecraft:spawn_reinforcements",base:0.0},{id:"minecraft:follow_range",base:4.0},{id:"minecraft:max_health",base:200.0},{id:"minecraft:name_tag_distance",base:16.0},{id:"minecraft:armor",base:0.0}]\
    }

# Real Mummy sword + armor (same defs as kits/mummy/givekit) but with the imperium_kit custom_data
# stripped and no im.kit_mummy tag, so the booth never scans/ticks it for abilities. All targeted by
# the im.dummy_new tag, so no per-piece positioning is needed.
item replace entity @e[type=husk,tag=im.dummy_new,limit=1] armor.head with \
    player_head[\
        attribute_modifiers=[\
            {type:"armor",amount:15,operation:"add_value",slot:head,id:"head"},\
            {type:"armor_toughness",amount:8,operation:"add_value",slot:head,id:"head"},\
            {type:"attack_knockback",amount:1,operation:"add_value",slot:"head",id:"head"},\
            {type:"knockback_resistance",amount:0.44,operation:"add_value",slot:"head",id:"head"},\
        ],\
        enchantments={"imperium:barrier":1,"protection":8},\
        !max_damage,\
        profile="Mummy",\
        item_model="minecraft:player_head",\
        custom_name={text:"Mummy Head",color:blue,italic:false}\
    ] 1
item replace entity @e[type=husk,tag=im.dummy_new,limit=1] armor.chest with \
    netherite_chestplate[\
        !attribute_modifiers,\
        !max_damage,\
        item_model="minecraft:netherite_chestplate",\
        equippable={slot:chest,asset_id:"minecraft:netherite"},\
        trim={material:"quartz",pattern:"silence"},\
        custom_name={text:"Mummy Chestplate",color:blue,italic:false}\
    ] 1
item replace entity @e[type=husk,tag=im.dummy_new,limit=1] armor.legs with \
    netherite_leggings[\
        !attribute_modifiers,\
        !max_damage,\
        item_model="minecraft:netherite_leggings",\
        equippable={slot:legs,asset_id:"minecraft:netherite"},\
        trim={material:"quartz",pattern:"rib"},\
        custom_name={text:"Mummy Leggings",color:blue,italic:false}\
    ] 1
item replace entity @e[type=husk,tag=im.dummy_new,limit=1] armor.feet with \
    netherite_boots[\
        !attribute_modifiers,\
        !max_damage,\
        item_model="minecraft:netherite_boots",\
        equippable={slot:feet,asset_id:"minecraft:netherite"},\
        trim={material:"quartz",pattern:"rib"},\
        custom_name={text:"Mummy Boots",color:blue,italic:false}\
    ] 1
item replace entity @e[type=husk,tag=im.dummy_new,limit=1] weapon.mainhand with \
    mace[\
        attribute_modifiers=[\
            {type:"attack_damage",amount:6,operation:add_value,slot:mainhand,id:"base_attack_damage"},\
            {type:"attack_speed",amount:-2.8,operation:add_value,slot:mainhand,id:"base_attack_speed"}\
        ],\
        enchantments={"imperium:golem_throw":1,"imperium:mace_smash":1},\
        !max_damage,\
        item_model="minecraft:netherite_sword",\
        custom_name={text:"Dark Claymore",color:dark_gray,italic:false}\
    ] 1

# No constant regen — it would drag down every damage-indicator reading (regen heals between the
# hit and the next HP sample). Instead the husk gets a deep HP pool (max_health 200) and the
# booth/dummy/dmg_tick loop heals it back to full during lulls (2s with no hits), which tops it up
# between flurries and visitors without ever masking a hit. Seed the indicator's HP baseline
# (Health x10 = 0.1-HP precision) and the no-hit counter so the first sampled tick reports no drop.
scoreboard players set @e[type=husk,tag=im.dummy_new,limit=1] im_hpPrev 2000
scoreboard players set @e[type=husk,tag=im.dummy_new,limit=1] im_dmgLull 0

tag @e[type=husk,tag=im.dummy_new] remove im.dummy_new
