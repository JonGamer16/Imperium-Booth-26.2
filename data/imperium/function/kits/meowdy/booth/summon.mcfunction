# Summon the Quin Meowdy selection stand: a bare display stand, then equip its
# show-only gear from the booth display loot tables (imperium:meowdy/display/*).
# Edit those tables to restyle the stand — the im_givekit function stays separate.
# Run once where you want the stand (or use imperium:booth/setup_stands for a test row).
summon minecraft:armor_stand ~ ~ ~ \
{   Marker:1b,\
    NoGravity:1b,\
    Invulnerable:1b,\
    NoBasePlate:1b,\
    ShowArms:1b,\
    CustomNameVisible:0b,\
    CustomName:{text:"Quin Meowdy",color:"gold",bold:true},\
    Tags:["im.booth_stand_model","im.booth_meowdy","im.booth_new"],\
    Pose:{Body:[0f,10f,7f],LeftLeg:[0f,0f,12f],RightLeg:[0f,0f,40f],LeftArm:[277f,20f,9f],RightArm:[284f,343f,360f]}\
}

execute at @e[type=armor_stand,tag=im.booth_new,limit=1] \
    rotated ~ ~ \
    run summon text_display ^ ^-0.5 ^0.7 \
    {   text:{text:"Quin Meowdy",color:"gold",bold:true},\
        billboard:"fixed",\
        see_through:1b,\
        Tags:["im.booth_stand_model","im.booth_meowdy"]\
    }

loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.head loot imperium:meowdy/display/head
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.chest loot imperium:meowdy/display/chest
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.legs loot imperium:meowdy/display/legs
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.feet loot imperium:meowdy/display/feet
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    weapon.mainhand loot imperium:meowdy/display/weapon
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    weapon.offhand loot imperium:meowdy/display/weapon

tag @e[type=armor_stand,tag=im.booth_new] remove im.booth_new

summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["summit.interactable","summit.static","im.booth_stand","im.booth_meowdy"],\
    data:{summit_interactable:{on_right_click:"execute on target run function imperium:kits/meowdy/booth/click"}}\
}
