# Side wall pitch / overview. Stand where the display should appear, then run.
execute at @s run summon text_display ~ ~ ~ \
    {Tags:["im_walltext","im_description"],\
    billboard:"fixed",\
    alignment:"center",\
    line_width:320,text:[\
        {text:"Overview",color:"gold",bold:true},{text:"\n\n",bold:false},\
        {text:"Imperium Mundi is a Kit PvP game where you must manage your HP and inventory as you fight. To outlast your opponent, you'll need to make the most of your kit's weapons, healing items, and special tools, which only regenerate from melee damage dealt and taken.",color:"yellow"},{text:"\n\n"},\
        {text:"The gameplay takes advantage of the new technical features from the latest Minecraft updates while staying grounded in traditional close-quarters combat. Some mechanics also take inspiration from older versions of Minecraft!",color:"yellow"},{text:"\n\n"},\
        {text:"Take a look at 7 fighters right down the hall!",color:yellow}]}
