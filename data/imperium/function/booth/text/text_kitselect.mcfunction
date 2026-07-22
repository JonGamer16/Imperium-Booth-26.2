# Kit room instructions. Stand where the display should appear, then run.
execute at @s \
    run summon text_display ~ ~ ~ {\
    Tags:["im_walltext","im_kitselect"],\
    billboard:"center",\
    alignment:"center",\
    line_width:250,\
    text:[\
        {text:"Choose Your Fighter",color:"gold",bold:true},{text:"\n\n",bold:false},\
        {text:"Right Click ",color:"gold"},{text:"to equip and see kit information",color:"yellow"},{text:"\n\n"},\
        {text:"Crouch + Right Click ",color:"gold"},{text:"for lore",color:"yellow"}]}
