   ________  ____________
  / .      \/           /
 /            .        /
/                     /
\   I M P E R I U M   \
 \                     L
  \      M U N D I      \
  /   .                 /
 /                   . /
/_____/\__________/\__/


Imperium Mundi Kit PvP Datapack
Ver 26.2 (format 101)
                                                                               |
About: This is a vanilla replica of Imperium Mundi, the free-for-all Kit PVP
minigame created by awesomebutter234 and JonGamer16. You pick a kit out of the
extensive roster and fight for gold to unlock new kits and other things. The
main aspects of the minigame are the large kit roster of over 45 kits, the
presence of items and fighting styles inspired by Minecraft combat in older
versions, and unique gameplay that pushes the mechanical bounds of vanilla
Minecraft combat.

                                                                               |
If you want to add to this datapack, here are the files you'll need to append
to add different things:

- Kits:

    1.  [Number] assign a unique number to it; check all the numbers in "givekit"
          [data/imperium/function/arena/givekit.mcfunction]

    2.  [givekit] make a call for it in "givekit"
          [data/imperium/arena/givekit.mcfunction]

    3.  [Kit Function] add a new function for it in "kits"
          [data/imperium/function/kits]

    4.  [Scoreboard tags] whatever items or abilities you want to add to it,
          make it set the player's tags or scoreboard value for those items

    5.  [? Summon Teams] if it uses a summon, add a team join command in the
          kit function. Right now it just puts you in a team for the mob type

- Healing Items:

    1.  [healing_items Function] add a new function for it in "healing_items"
          [data/imperium/function/healing_items]
          
    2.  [main] create a scoreboard objective for it in "main"
          [data/imperium/function/main.mcfunction]

    3.  [death] add a score reset command in "death"
          [data/imperium/function/arena/death.mcfunction]

- Kit Items:

    1.  [items Function] add a new function for it in "items"
          [data/imperium/function/items]

    2.  [main] create a scoreboard objective for it in "main"
          [data/imperium/function/main.mcfunction]

    3.  [? loop] if it reloads by damage, add an item reload function in "loop"
          [data/imperium/function/loop.mcfunction]

    4.  [? kill] if it reloads on kill, call the function for it in "kill"
          [data/imperium/function/arena/kill.mcfunction]

    5.  [death] add a score reset command in "death"
          [data/imperium/function/arena/death.mcfunction]

- Summon Items:

    1.  [items Function] add a new function for it in "summon_items"
          [data/imperium/function/summon_items]

    2.  [? Team] if it's a hostile mob that needs to not attack the player, add
          a team for it in "main" [data/imperium/function/main.mcfunction]

        (Note) I might add dynamic team creation to make it per player in
          the future, calling for a change in this step

    3.  [main] create a scoreboard objective for the item in "main"
          [data/imperium/function/main.mcfunction]

    4.  [? loop] if it reloads by damage, add an item reload command in "loop"
          [data/imperium/function/loop.mcfunction]

    5.  [? kill] if it reloads on kill, call the function for it in "kill"
          [data/imperium/function/arena/kill.mcfunction]

    6.  [death] add a score reset command in "death"
          [data/imperium/function/arena/death.mcfunction]