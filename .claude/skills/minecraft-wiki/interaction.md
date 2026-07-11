**Interaction Entity NBT**

[Float] width: The width of the entity's bounding box. Defaults to 1.
[Float] height: The height of the entity's bounding box. Defaults to 1.
[Byte] response: 1 or 0 (true/false). Specifies whether an interaction should trigger a response (hand animation). Defaults to 0 (false).
[NBT Compound / JSON Object] attack: The last attack (left click) to hit the entity.
[Int Array] player: The UUID of the player that attacked the entity. The 128-bit UUID is stored as four 32-bit integers, ordered from most to least significant.
[Long] timestamp: When the attack took place.
[NBT Compound / JSON Object] interaction: The last interaction (right click) to hit the entity.
[Int Array] player: The UUID of the player that interacted with the entity. The 128-bit UUID is stored as four 32-bit integers, ordered from most to least significant.
[Long] timestamp: When the interaction took place.

**Commands**

*execute anchored eyes run tp @n[type=interaction,...] ^ ^-0.001 ^3* - run as the player to teleport the tracker interaction exactly to the player's crosshair

*execute anchored eyes run summon interaction ^ ^-0.001 ^3 {width:0.01,height=0.01}* - summon a new interaction entity at the executing player's crosshair