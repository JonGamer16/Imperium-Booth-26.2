# **Booth Definition**

This file defines your booth’s metadata which includes information such as the name of your booth, the dimensions of the bounding box that defines it, and more. Each booth is **required** to define this file (and only one) which will be submitted alongside your data and resource packs. We’ve explained the exact structure of this file alongside which fields are required or not at the end of this page.

**No** fields should be namespaced with the exception of resource locations, such as your functions and textures. Every other field unique to your booth will use the supplied ‘namespace’ field.

***Note**: this definition is growing and changing as we add new systems so look out for updates in the vendor announcement channels in the discord\!*

## The Basic JSON structure

| {    "namespace": "\<booth\_id\>",    "booth\_name": "\<Booth Name\>",    "bounding\_boxes": {        "my\_box": {            "position": {                "x": {"min": \-135, "max": \-102},                "y": {"min": 70, "max": 95},                "z": {"min": \-39, "max": \-20}            },            "on\_player\_enter": "\<function\_location\>",            "on\_player\_exit": "\<function\_location\>"        },         ...    },     "on\_player\_enter": "\<function\_location\>",     "on\_player\_exit": "\<function\_location\>",    "ticking\_functions": {        "\<booth\_id\>:tick": "1t",        "\<booth\_id\>:sec": "1s",         ...    },    "sticker\_book": {        "background\_color": "\#1a48c3",        "region": "textured\_tropics",        "stickers": \[            {                "sticker\_id": "\<sticker\_id\>",                "sticker\_texture": "\<texture\_location\>",                "sticker\_name": "Welcome to Booth",                "unobtained\_text": "Enter the Booth",                "obtained\_text": "Rewarded for entering the Booth"            },             ...        \]    },     "balloons": \[         {             "balloon\_id": "smithie",             "balloon\_name": "Smithie",             "balloon\_model": "summit\_balloons:item/smithie"         }     \]} |
| :---- |
|  |

## Field Explanations

- namespace :  For your submitted data pack and resource pack, you are only permitted to use one namespace, unless you have extenuating circumstances. List that namespace here. This acts as an id for your booth.  
- booth\_name :  The name of your booth, this is used for display so you can use characters like &.  
- bounding\_boxes :  This is an object containing named spacial bounding boxes for your booth. Think of these as arbitrary cuboid volumes that you can define. Combined they should cover the entire area of your booth.  
  - \<bounding\_box\_name\> :  Name the bounding box whatever you want  
    - position :  Defines the area of the bounding box itself, with each value being a float. See above.  
    - on\_player\_enter :  (Optional) A function location that will be run as and at a player when they enter this specific bounding box  
    - on\_player\_exit :  (Optional) A function location that will be run as and at a player when they enter this specific bounding box  
- on\_player\_enter :  (Optional) A function location that will be run as and at a player when they enter your booth as a whole. (When a player goes from not being in any bounding box to being in at least one)  
- on\_player\_exit :  (Optional) A function location that will be run as and at a player when they exit your booth as a whole. (When a player goes from being in at least one bounding box to not being in any)  
- ticking\_functions :  (Optional) A map of function locations and their timings for ticking. These will only be run when a player is in one of the bounding boxes you defined above for your booth. If you think you have reason to be ticking functions otherwise, please ping your assigned coordinator to inquire.  
- sticker\_book :  (Optional) This summit we will be providing players with a sticker book. Booths will be able to register stickers through here and then grant them how they want via generated advancement.  
  - background\_color :  Each booth will have a strip of tape where their stickers are displayed in the sticker book. Define the color of your tape here as a hex code.  
  - region :  Either patched\_plateaus, textured\_tropics, or welded\_woodlands.  
  - stickers :  Each booth is permitted up to 5 stickers. List them here.  
    - sticker\_id :  A technical id for this sticker, these are automatically namespaced using your booth’s namespace to avoid collisions with other booths. The advancement for the sticker will be located at summit.sticker\_book:\<namespace\>/\<sticker\_id\>. The advancement is generated and should be granted to reward the player with the sticker.  
    - sticker\_texture :  A resource location for a texture in your resource pack to use for the sticker, e.g. my\_booth:sticker/on\_enter  
    - sticker\_name :  The name of this sticker, will show on hover.  
    - unobtained\_text :  Text to display on hover for this sticker when it is yet to be obtained. When unobtained, stickers will show as a silhouette of the sticker.  
    - obtained\_text :  Text to display on hover for this sticker when it has been obtained.  
- balloons :  (Optional) Balloons are a cosmetic item that booths can give out to players. Booths will be able to register balloons through here and then grant them how they want via a generated function, or via the balloon vendor as described in the Interaction API section.  
  - balloon\_id : A technical id for this balloon, these are automatically namespaced using your booth’s namespace to avoid collisions with other booths. A function for the balloon will be located at summit.balloon:give/\<namespace\>/\<balloon\_id\>.  
  - balloon\_name : The name of this balloon, will be the name of the balloon item.  
  - balloon\_model : A resource location for a model in your resource pack to use for the balloon, e.g. my\_booth:balloon/basic