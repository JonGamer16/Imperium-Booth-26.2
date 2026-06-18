# Summon the Livvy the Vampire Spider selection stand: a bare display stand, then equip
# its show-only gear from the booth display loot tables (imperium:livvy/display/*).
# Edit those tables to restyle the stand — the givekit function stays separate.
# Run once where you want the stand (or use imperium:booth/setup_stands for a test row).
summon minecraft:armor_stand ~ ~ ~ \
{   Marker:1b,\
    NoGravity:1b,\
    Invulnerable:1b,\
    NoBasePlate:1b,\
    ShowArms:1b,\
    CustomNameVisible:1b,\
    CustomName:{text:"Livvy the Vampire Spider",color:"red",bold:true},\
    Tags:["im.booth_stand_model","im.booth_livvy","im.booth_new"],\
    Pose:{RightArm:[-100f,0f,-10f],LeftArm:[-15f,0f,10f]}\
}
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.head loot imperium:livvy/display/head
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.chest loot imperium:livvy/display/chest
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.legs loot imperium:livvy/display/legs
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.feet loot imperium:livvy/display/feet
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    weapon.mainhand loot imperium:livvy/display/weapon

tag @e[type=armor_stand,tag=im.booth_new] remove im.booth_new

summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["im.booth_stand","im.booth_livvy"]\
}
