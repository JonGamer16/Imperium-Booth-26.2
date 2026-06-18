# **Ticking your Booth**

For Summit, we completely handle all of the ticking logic for your booth. In order to register a ticking function, you’ll define a new entry in the ticking\_functions field of your [**Booth Definition**](?tab=t.5lmhbhoqu627) letting you define specific functions to be ticked at specific rates (once a tick, once a second, etc.) This lets us only tick your booth if there are players within it and also lets us multi-thread all of the booths’ ticking code as we please.

# Booth Events

In order to detect when someone enters and exits your booth, you should refer to the bounding\_boxes field of your [**Booth Definition**](?tab=t.5lmhbhoqu627). This lets you define multiple bounding boxes that mostly encompass the space your booth needs for its interactivity. You can define functions for on\_player\_enter and on\_player\_exit to detect when a player enters and exits the entire booth as a whole alongside defining said fields for each bounding box within. This should give you a degree of control if you need special sub-booth regional events while still managing a player within your booth.

# Other Useful Techniques

In order to tick your booth, we generate a location predicate that checks for a player within the booth region. You can reference this predicate in any advancements as you please, more information [**here**](?tab=t.49tqhrd4y2g5). We also tag the player with summit.in\_booth.\<namespace\> which you can also leverage to detect if someone is in the booth, more information defined [**here**](?tab=t.7uu67polxf62).

# Persistent Booth Ticking

While we have designed Summit to have the majority of booth vendors leverage the booth event system for ticking their booth, there may come a moment where you require ticking commands outside of your booth’s presence. These should be considered carefully and with intention as to not add a ton of load to our servers.

## Schedule Clocks

These can be used to have controllable clocks at varying speeds for a temporary ticking sequence. For example, if you have an animated entrance that triggers when someone enters your booth, you may want to schedule a slow clock (like every 2t or 5t) that checks if the mouth needs to be closed if the animation state gets stuck and your booth stops ticking. You can use schedule function \<my\_func\> 5t replace  in a function that schedules itself until a condition is met to handle these sorts of cases. These should be used for short, burst ticking clocks and not for extended ticking sequences.

## Persistent Booth Ticking

If you have a function that needs to be ticked every tick (even within some condition), there will be a persistent tick available for your booth that will be triggered every tick. You should *only* leverage this in the case where you have some heavy or expensive logic (mostly things that require commands every tick) that needs to work outside of someone within your booth region. These will be closely monitored and approved case by case. You should always have a single score or flagged condition that precedes any expensive selector or function call to try to reduce the number of tickly commands as much as possible\!

Information on how to leverage this …. Coming soon\!