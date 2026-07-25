# Side wall pitch / overview. Stand where the display should appear, then run.
summon minecraft:text_display ~ ~1 ~ {\
    alignment: "center", \
    background: 1073741824, \
    default_background: 0b, \
    line_width: 200, \
    see_through: 0b, \
    shadow: 0b, \
    text: {\
        bold: true, color: "gold", text: "Overview"}, \
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
        text: "   This is a Kit PvP game where you must manage your HP and inventory as you fight. \n"},\
    {bold: 0b, color: "yellow", \
        text: "   To outlast your opponent, you'll need to make the most of your kit's weapons, healing items, and special tools, which only regenerate from melee damage dealt and taken.\n"},\
    {bold: 0b, color: "yellow", \
        text: "   The gameplay takes advantage of the new technical features from the latest Minecraft updates while staying grounded in traditional close-quarters combat.\n"},\
    {bold: 0b, color: "yellow", \
        text: "   Some items also mimic combat from old and experimental versions of Minecraft!\n"},\
    {bold: 0b, color: "yellow", \
        text: "   Try out 7 fighters right down the hall!"}], text: ""}, \
text_opacity: 255, \
transformation: {\
    left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], \
    right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], \
    scale: [1.0f, 1.0f, 1.0f], \
    translation: [0.0f, 0.0f, 0.0f]},\
view_range:0.25f}