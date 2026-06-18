# **Booth Schematic**

# Pasting your Booth

After onboarding, you’ll be provided with a copy of the schematic alongside a tp command with exact coords and some brief instructions ([**example**](?tab=t.s2xylz8e5yjv#heading=h.npjd7gllncts)). Most importantly, you should ensure the following things are true:

- /gamerule random\_tick\_speed 0  
- //perf off 		(World edit command)  
- Be very careful with block updates. Ideally use axiom with the No Updates option enabled.

# Schematic Entity Transfer

When you submit your booth, you will submit a WorldEdit schematic with any [**static entities**](?tab=t.yjy5zgxgodco) you want to include. (Make sure to use \-e to the copy command)  
These entities will be stripped out of the schematic and automatically moved to summon commands.

However, transferring entities is not simple and there are a lot of caveats; this will only transfer the data on the entity, **not scores**.

Therefore, any entities in your booth that use scores (including Animated Java rigs) should be summoned and killed via functions and **should not** be included in your schematic.

There are 2 function tags that you should add these summon and kill commands of these special entities:

- \#summit.booth:\<namespace\>/entities/summon  
- \#summit.booth:\<namespace\>/entities/kill 

Where  \<namespace\> is the same namespace you specified in your [**Booth Definition**](?tab=t.5lmhbhoqu627).

You can of course use these function tags for your static entities as well, but keep in mind, if you handle entities through these summon and kill function tags, DO NOT LEAVE THEM IN YOUR SCHEMATIC.

# Saving your Booth

…  
