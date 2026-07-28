# Front entrance branding. Stand where the display should appear, then run.
execute at @s run \
    summon text_display ~ ~ ~ \
        {Tags:["summit.booth_entity.imperium", "im_walltext","im_title"],\
        billboard:"fixed",\
        alignment:"center",\
        line_width:250,\
        text:[\
            {text:"Imperium Mundi ",color:"gold"},{text:"- by JonGamer16",color:"yellow"},\
            {text:"Welcome to the Dojo",color:"yellow"},{text:"\n\n"}]}
