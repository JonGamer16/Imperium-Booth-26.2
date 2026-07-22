# Summon the Smokey Bat selection stand: a bare display stand, then equip its
# show-only gear from the booth display loot tables (imperium:smokey/display/*).
# Edit those tables to restyle the stand — the im_givekit function stays separate.
# Run once where you want the stand (or use imperium:booth/setup_stands for a test row).

summon minecraft:armor_stand ~ ~ ~ \
{   Marker:1b,\
    NoGravity:1b,\
    Invulnerable:1b,\
    NoBasePlate:1b,\
    ShowArms:1b,\
    CustomNameVisible:0b,\
    CustomName:{text:"Smokey Bat",color:"gold",bold:true},\
    Tags:["im.booth_stand_model","im.booth_smokey","im.booth_new"],\
    Pose:{Body:[15f,0f,0f],Head:[69f,0f,0f],LeftLeg:[316f,0f,0f],RightLeg:[45f,0f,5f],LeftArm:[12f,0f,291f],RightArm:[15f,0f,72f]}\
}

execute at @e[type=armor_stand,tag=im.booth_new,limit=1] \
    rotated ~ ~ \
    run summon text_display ^ ^-0.5 ^0.7 \
    {   text:{text:"Smokey Bat",color:"gold",bold:true},\
        billboard:"fixed",\
        see_through:1b,\
        Tags:["im.booth_stand_model","im.booth_smokey"]\
    }

loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.head loot imperium:smokey/display/head
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.chest loot imperium:smokey/display/chest
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.legs loot imperium:smokey/display/legs
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.feet loot imperium:smokey/display/feet
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    weapon.mainhand loot imperium:smokey/display/weapon
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    weapon.offhand loot imperium:smokey/display/offhand

tag @e[type=armor_stand,tag=im.booth_new] remove im.booth_new

summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["summit.interactable","summit.static","im.booth_stand","im.booth_smokey"],\
    data:{summit_interactable:{on_right_click:"execute on target run function imperium:kits/smokey/booth/click"}}\
}
