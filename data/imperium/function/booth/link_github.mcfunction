# RE-ARM FIRST. This function is the reward of imperium:booth/link_github, and an advancement stays
# granted once earned — so without this revoke the stand fires exactly ONCE per player and is
# then dead forever. It used to be double-wired (Summit's Interactions API called it too, via
# the summit.interactable tag on the interaction), which hid the problem; that API is gone and
# the advancement is now the only path in. Must be the FIRST line — the guards below `return`
# early, and a return before the revoke would leave the stand permanently dormant.
advancement revoke @s only imperium:booth/link_github

# GitHub link sign — reward of imperium:booth/link_github, so this already runs AS the clicking
# player. Whispers the link to them only; nobody else sees it.
#
# Vanilla cannot open a browser from an entity click — click_event/open_url only works on chat text —
# so printing a clickable line IS the intended behaviour here, not a fallback.
tellraw @s [{"text":"[Imperium] ","color":"gold"},{"text":"GitHub Repository","color":"aqua","underlined":true,"click_event":{"action":"open_url","url":"https://github.com/JonGamer16/Imperium-Mundi-Data-Pack"},"hover_event":{"action":"show_text","value":{"text":"https://github.com/JonGamer16/Imperium-Mundi-Data-Pack","color":"gray"}}}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 0.5 1.2
