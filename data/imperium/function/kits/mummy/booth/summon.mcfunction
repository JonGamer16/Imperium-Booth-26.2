# Summon the Warforged Mummy selection stand: a bare display stand, then equip its
# show-only gear from the booth display loot tables (imperium:mummy/display/*).
# Edit those tables to restyle the stand — the givekit function stays separate.
# Run once where you want the stand (or use imperium:booth/setup_stands for a test row).
summon minecraft:armor_stand ~ ~ ~ \
{   Marker:1b,\
    NoGravity:1b,\
    Invulnerable:1b,\
    NoBasePlate:1b,\
    ShowArms:1b,\
    CustomNameVisible:1b,\
    CustomName:{text:"Mummy",color:"gray",bold:true},\
    Tags:["im.booth_stand_model","im.booth_mummy","im.booth_new"],\
    Rotation:[-70f,0f],\
    Pose:{Head:[7f,343f,0f],LeftLeg:[337f,343f,0f],RightLeg:[17f,360f,5f],LeftArm:[244f,346f,10f],RightArm:[335f,360f,18f]}\
}
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.head loot imperium:mummy/display/head
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.chest loot imperium:mummy/display/chest
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.legs loot imperium:mummy/display/legs
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.feet loot imperium:mummy/display/feet
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    weapon.mainhand loot imperium:mummy/display/weapon
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    weapon.offhand loot imperium:mummy/display/offhand

tag @e[type=armor_stand,tag=im.booth_new] remove im.booth_new

summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["im.booth_stand","im.booth_mummy"]\
}
