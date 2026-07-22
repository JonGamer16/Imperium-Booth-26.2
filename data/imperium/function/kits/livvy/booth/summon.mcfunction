# Summon the Livvy the Vampire Spider selection stand: a bare display stand, then equip
# its show-only gear from the booth display loot tables (imperium:livvy/display/*).
# Edit those tables to restyle the stand — the im_givekit function stays separate.
# Run once where you want the stand (or use imperium:booth/setup_stands for a test row).

#   Main Armor Stand: Armor, fangs
summon minecraft:armor_stand ~ ~ ~ \
{   Marker:1b,\
    NoGravity:1b,\
    Invulnerable:1b,\
    NoBasePlate:1b,\
    ShowArms:1b,\
    CustomNameVisible:0b,\
    CustomName:{text:"Livvy",color:"red",bold:true},\
    Tags:["im.booth_stand_model","im.booth_livvy","im.booth_new"],\
    Rotation:[-90,0],\
    Pose:{Body:[5f,0f,0f],Head:[10f,0f,0f],LeftLeg:[345f,360f,345f],RightLeg:[13f,0f,16f],LeftArm:[288f,349f,335f],RightArm:[304f,12f,52f]}\
}

execute at @e[type=armor_stand,tag=im.booth_new,limit=1] \
    rotated ~ ~ \
    run summon text_display ^ ^-0.5 ^0.7 \
    {   text:{text:"Livvy",color:"red",bold:true},\
        billboard:"fixed",\
        see_through:1b,\
        Tags:["im.booth_stand_model","im.booth_livvy"]\
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
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    weapon.offhand loot imperium:livvy/display/soup

tag @e[type=armor_stand,tag=im.booth_new] remove im.booth_new

# Second Armor Stand: 
summon minecraft:armor_stand ~ ~-0.25 ~ \
{   Marker:1b,\
    NoGravity:1b,\
    Invulnerable:1b,\
    NoBasePlate:1b,\
    ShowArms:1b,\
    Tags:["im.booth_stand_model","im.booth_livvy","im.booth_new"],\
    Rotation:[-90,0],\
    Pose:{Body:[0f,2f,0f],Head:[180f,0f,0f],LeftLeg:[180f,0f,0f],RightLeg:[175f,0f,0f],LeftArm:[273f,68f,209f],RightArm:[260f,290f,170f]}\
}

tag @e[type=armor_stand,tag=im.booth_new] remove im.booth_new

# Third Stand: Holding a Web in both hands

summon minecraft:armor_stand ~ ~-0.5 ~ \
{   Marker:1b,\
    NoGravity:1b,\
    Invulnerable:1b,\
    NoBasePlate:1b,\
    ShowArms:1b,\
    Tags:["im.booth_stand_model","im.booth_livvy","im.booth_new"],\
    Rotation:[-90,0],\
    Pose:{Body:[0f,2f,0f],Head:[180f,0f,0f],LeftLeg:[180f,0f,0f],RightLeg:[175f,0f,0f],LeftArm:[265f,7f,250f],RightArm:[296f,7f,340f]}\
}
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    weapon.offhand loot imperium:livvy/web

tag @e[type=armor_stand,tag=im.booth_new] remove im.booth_new



summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["summit.interactable","summit.static","im.booth_stand","im.booth_livvy"],\
    data:{summit_interactable:{on_right_click:"execute on target run function imperium:kits/livvy/booth/click"}}\
}
