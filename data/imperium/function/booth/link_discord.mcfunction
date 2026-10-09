# RE-ARM FIRST. This function is the reward of imperium:booth/link_discord, and an advancement stays
# granted once earned — so without this revoke the stand fires exactly ONCE per player and is
# then dead forever. It used to be double-wired (Summit's Interactions API called it too, via
# the summit.interactable tag on the interaction), which hid the problem; that API is gone and
# the advancement is now the only path in. Must be the FIRST line — the guards below `return`
# early, and a return before the revoke would leave the stand permanently dormant.
advancement revoke @s only imperium:booth/link_discord

# Discord link sign — reward of imperium:booth/link_discord, so this already runs AS the clicking
# player. Whispers the link to them only; nobody else sees it. See booth/link_github for why a
# clickable chat line is the intended behaviour rather than a browser-opening click.
tellraw @s [{"text":"[Imperium] ","color":"gold"},{"text":"Discord Server","color":"blue","underlined":true,"click_event":{"action":"open_url","url":"https://discord.gg/kXyqnskP2x"},"hover_event":{"action":"show_text","value":{"text":"https://discord.gg/kXyqnskP2x","color":"gray"}}}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 0.5 1.2
