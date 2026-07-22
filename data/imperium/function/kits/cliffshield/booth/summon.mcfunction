# Summon the Jeru Cliffshield selection stand: a bare display stand, then equip its
# show-only gear from the booth display loot tables (imperium:cliffshield/display/*).
# Edit those tables to restyle the stand — the im_givekit function stays separate.
# Run once where you want the stand (or use imperium:booth/setup_stands for a test row).
summon minecraft:armor_stand ~ ~ ~ \
{   Marker:1b,\
    NoGravity:1b,\
    Invulnerable:1b,\
    NoBasePlate:1b,\
    ShowArms:1b,\
    CustomNameVisible:0b,\
    CustomName:{text:"Jeru Cliffshield",color:"yellow",bold:true},\
    Tags:["im.booth_stand_model","im.booth_cliffshield","im.booth_new"],\
    Rotation:[-90,0],\
    Pose:{Body:[7f,14f,0f],Head:[5f,335f,0f],LeftLeg:[346f,325f,0f],RightLeg:[360f,14f,13f],LeftArm:[277f,23f,0f],RightArm:[337f,341f,50f]}\
}

execute at @e[type=armor_stand,tag=im.booth_new,limit=1] \
    rotated ~ ~ \
    run summon text_display ^ ^-0.5 ^0.7 \
    {   text:{text:"Jeru Cliffshield",color:"yellow",bold:true},\
        billboard:"fixed",\
        see_through:1b,\
        Tags:["im.booth_stand_model","im.booth_cliffshield"]\
    }

loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.head loot imperium:cliffshield/display/head
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.chest loot imperium:cliffshield/display/chest
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.legs loot imperium:cliffshield/display/legs
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    armor.feet loot imperium:cliffshield/display/feet
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    weapon.mainhand loot imperium:cliffshield/display/weapon
loot replace entity @e[type=armor_stand,tag=im.booth_new,limit=1] \
    weapon.offhand loot imperium:cliffshield/shield

tag @e[type=armor_stand,tag=im.booth_new] remove im.booth_new

# The interaction is the clickable hitbox. Summit's interaction handler only scans
# type=interaction entities tagged summit.interactable, and reads interaction.timestamp
# (needs response:1b), so on_right_click must live here — not on the text_display.
summon minecraft:interaction ~ ~ ~ \
{   width:1.0f,height:2.1f,response:1b,\
    Tags:["summit.interactable","summit.static","im.booth_stand","im.booth_cliffshield"],\
    data:{summit_interactable:{on_right_click:"execute on target run function imperium:kits/cliffshield/booth/click"}}\
}
