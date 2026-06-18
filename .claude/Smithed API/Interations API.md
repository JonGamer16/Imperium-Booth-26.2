# **KInteractions API**

To aid in booth development, we’ve created a shortcut for running commands from actions on interaction entities. All you need to do is tag the interaction and add some custom data.

| summon interaction \~ \~ \~ {Tags: \["summit.interactable", "summit.static"\], data: {summit\_interactable: {on\_right\_click: "execute on target run function a:bc"}}} |
| :---- |

This will summon an interaction entity that will run function a:bc as the player that right clicked on the interaction. Any command in the on\_right\_click or on\_left\_click fields are run as / at the interaction. To have them target the player you have to include execute on target run for right click or execute on attacker run for left click. 

As a special form of the Interactions system, you can enable a player to sit by right clicking on the interaction. This is done by setting  special: "sit" in the summit\_interactable data field. You can also specify the height above the bottom of the interaction that a player will sit with an optional height field in summit\_interactable, if absent, this will be half of the interaction's main  height field.

| summon interaction \~ \~ \~ {Tags: \["summit.interactable", "summit.static"\], data: {summit\_interactable: {special:"sit",height:0.5}}} Another special form can give players a specific balloon by right clicking on the interaction. This is done by setting special: "balloon\_vendor" in the summit\_interactable data field. This type requires some extra fields to be set to specify which balloon to give. namespace must be set to your booth’s namespace, as defined in your booth definition. balloon\_id must be set to the id of the balloon to give, as defined in your booth definition. These types of interactions have a cooldown specific to each balloon, which resets after 20 minutes. summon interaction \~ \~ \~ {Tags: \["summit.interactable", "summit.static"\], data: {summit\_interactable: {special:"balloon\_vendor",namespace:”smithed”,balloon\_id:"smithie"}}} |
| :---- |

### Static Tagging

You can tag these entities with summit.static if you never plan on moving or editing the hitbox of the entity after you spawn them in. This would be ideal for the common sitting entities for the benches across Summit for example. You can read more about static entities [**here**](?tab=t.yjy5zgxgodco#heading=h.mrf4vil82wib).  
