# Summon the Rastus the Duelist selection stand: a bare display stand, then equip its
# show-only gear from the booth display loot tables (imperium:rastus/display/*).
# Edit those tables to restyle the stand — the givekit function stays separate.
# Run once where you want the stand (or use imperium:booth/setup_stands for a test row).
summon minecraft:armor_stand ~ ~ ~ \
{   Marker:1b,\
    NoGravity:1b,\
    Invulnerable:1b,\
    NoBasePlate:1b,\
    ShowArms:1b,\
    CustomNameVisible:1b,\
    CustomName:{text:"Rastus",color:"blue",bold:true},\
    Tags:["im.booth_stand_model","im.booth_rastus","im.booth_new"],\
    Rotation:[225f,0f],\
    Pose:{Head:[9f,40f,0f],LeftLeg:[360f,358f,353f],RightLeg:[350f,43f,0f],LeftArm:[30f,0f,350f],RightArm:[312f,25f,338f]},\
}
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.head loot imperium:rastus/display/head
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.chest loot imperium:rastus/display/chest
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.legs loot imperium:rastus/display/legs
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.feet loot imperium:rastus/display/feet
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    weapon.mainhand loot imperium:rastus/display/weapon

tag @e[type=armor_stand,tag=im.booth_new] remove im.booth_new

summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["im.booth_stand","im.booth_rastus"]\
}
