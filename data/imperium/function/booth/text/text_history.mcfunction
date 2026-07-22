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
    {bold: 1b, color: "gold", extra: [{bold: 0b, text: "\n\n"}, \
    {bold: 0b, color: "yellow", \
        text: "   Imperium was once a lump of command blocks and then a Spigot server that got fleshed out and released. There, the kit roster peaked at 46.\n"},\
    {bold: 0b, color: "yellow", \
        text: "   Some kits summoned mobs, some had magic spells, and some had bizarre behaviors with knockback and the hit cooldown as early as Minecraft 1.16.\n"},\
    {bold: 0b, color: "yellow", \
        text: "   In a time where KitPvP servers were shifting toward tiny plain rosters, I and a friend wanted to push back with a novelty, so we worked on the server on and off over several years.\n"},\
    {bold: 0b, color: "yellow", \
        text: "   We released it and got a lot of support from our small community, but as updates kept changing the game's backend, it became too hard to keep updating and maintaining the kits, so it eventually died.\n"},\
    {bold: 0b, color: "yellow", \
        text: "   Now, I'm reviving Imperium with new features as a data pack so it can be played any time and anywhere!\n"},\
    {bold: 0b, color: "yellow", \
        text: "   "}], text: ""}, \
text_opacity: 255, \
transformation: {\
    left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], \
    right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], \
    scale: [0.5f, 0.5f, 0.5f], \
    translation: [0.0f, 0.0f, 0.0f]},\
view_range:0.25f}

    