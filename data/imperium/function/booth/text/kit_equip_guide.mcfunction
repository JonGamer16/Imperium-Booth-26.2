execute at @s run summon text_display ~ ~ ~ \
    {Tags:["im_walltext","im_kitselect"],\
    billboard:"center",\
    alignment:"center",\
    line_width:250,\
    text:[\
        {text:"[RMB] ",color:"gold"},{text:"Select Kit",color:"yellow"},{text:"\n\n"},\
        {text:"[Shift]+[RMB] ",color:"gold"},{text:"View Lore",color:"yellow"}]}
