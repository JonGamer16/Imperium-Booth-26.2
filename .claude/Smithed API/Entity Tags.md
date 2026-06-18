# **Entity Tags**

summit.static

- Any entity tagged with summit.static will not send any updates to the client. You can still target and update them, but it will not present any changes visually as [**they will not tick**](?tab=t.yjy5zgxgodco).  
- By default, any entity included in the Schematic will be tagged with summit.static, but you can override this by tagging it with summit.dynamic instead.

summit.booth\_entity.\<namespace\>

- Ensure to tag **ALL** of your entities with this. We need to be able to target the entities exclusively from your booth. Entities included in the booth schematic will automatically be tagged with this.

summit.in\_booth.\<namespace\>

- If a player is within any one of the bounding boxes you defined in the [**Booth Definition**](?tab=t.5lmhbhoqu627), they will be tagged with this. Use this to target players in your booth.