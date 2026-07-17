# Credits wall. Stand where the display should appear, then run.
execute at @s run summon text_display ~ ~ ~ \
    {Tags:["im_walltext","im_credits"],\
    billboard:"fixed",\
    alignment:"center",\
    line_width:340,\
    text:[\
        {text:"Datapack and booth mechanics created by ",color:"yellow"},{text:"JonGamer16",color:"green"},{text:"\n\n"},\
        {text:"Special Thanks:",color:"gold",bold:true},{text:"\n",bold:false},\
        {text:"awesomebutter234",color:"gold"},{text:" - Original server co-creator",color:"yellow"},{text:"\n"},\
        {text:"theuwufurry",color:"gold"},{text:" - Co-developer of original server and other projects; shared a Claude subscription with me",color:"yellow"},{text:"\n"},\
        {text:"B1ue_Bandit",color:"gold"},{text:" - Community member who provided funding for the original server",color:"yellow"},{text:"\n"},\
        {text:"rx98",color:"gold"},{text:" - Told me about the Smithed Summit and invited me in",color:"yellow"},{text:"\n\n"},\
        {text:"Smithed Staff and Baobab Battlegrounds booths",color:"gold"},{text:" - Technical help with booth and datapack",color:"yellow"},{text:"\n\n"},\
        {text:"AI was used to help with the background work of this datapack, but all of the gameplay design, features, building, and text is human-made.",color:"gold"}]}
