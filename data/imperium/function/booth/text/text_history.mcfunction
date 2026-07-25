# Mid-floor history board
summon minecraft:text_display ~ ~1 ~ {\
    alignment: "center", \
    background: 1073741824, \
    default_background: 0b, \
    line_width: 200, \
    see_through: 0b, \
    shadow: 0b, \
    text: {\
        bold: true, color: "gold", text: "A Brief History"}, \
        transformation: {\
            left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], \
            right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], \
            scale: [1.5f, 1.5f, 1.5f], \
            translation: [0.0f, 0.0f, 0.0f]},\
view_range:0.25f}

summon minecraft:text_display ~ ~ ~ {\
alignment: "left", \
background: 0, \
default_background: 0b, \
line_width: 240, \
see_through: 0b, \
shadow: 1b, \
text: \
    {bold: 1b, color: "gold", extra: [{bold: 0b, text: "\n\n"}, {bold: 0b, color: "yellow",text: "   Imperium was once a lump of command blocks and then a Spigot server that got fleshed out and released. There, the kit roster peaked at 46.\n"},{bold: 0b, color: "yellow",text: "   Some kits summoned mobs, some had magic spells, and some had bizarre behaviors with knockback and the hit cooldown as early as Minecraft 1.16.\n"},{bold: 0b, color: "yellow",text: "   Back when the 1.9 Combat Update was new and controversial, I noticed KitPvP servers started shifting toward tiny plain rosters of just diamond armor, or stayed in 1.8. I and awesomebutter234 wanted to push back with a novelty, so we worked on the server on and off over several years with a central concept of using both 1.8 and 1.9 combat in one gamemode.\n"},{bold: 0b, color: "yellow",text: "   We eventually released it and got a lot of support from our small community, but as updates kept changing the game's backend, it became too hard to keep updating and maintaining the kits, so it eventually fizzled out.\n"},{bold: 0b, color: "yellow",text: "   Now, I'm reviving Imperium with new features as a data pack so it can be played anytime and anywhere!\n"},{bold: 0b, color: "yellow",text: "   The lesson learned: code can go bad over time and break despite never changing on its own. Something updates, then the old code suddenly outputs major errors it didn't before."}], text: ""}, \
text_opacity: 255, \
transformation: {\
    left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], \
    right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], \
    scale: [0.5f, 0.5f, 0.5f], \
    translation: [0.0f, 0.0f, 0.0f]},\
view_range:0.25f}

    