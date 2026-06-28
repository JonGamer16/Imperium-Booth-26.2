# Reversal — reward of imperium:enchantments/reversal_block (fires as @s = the blocking
# player). When a Levent player blocks an attack while sneaking with the Reversal shield, warp
# them to the farthest clear spot directly behind the attacker (up to 2.5 blocks back), facing
# the attacker's back. It steps -0.5 -> -1.5 -> -2.5 and lands on the last clear step, so a
# deeper landing keeps a gap; if even -0.5 is blocked, nothing happens.

# Re-arm the detector so the next blocked hit can trigger it again.
advancement revoke @s only imperium:enchantments/reversal_block

# Player Disambiguation with tags

    # Only Levent triggers this (other kits' shields must not). Gate on the kit tag, not the shield
    # item: a block that breaks the shield removes it from the offhand before this runs, and the
    # reversal should still fire on that final block. Levent only carries the Reversal shield, so
    # the tag is an equivalent check that survives the break.
    execute unless entity @s[tag=im.kit_levent] run return fail

    # Clear markers a prior interrupted run may have left behind, so the step functions can only
    # ever resolve THIS defender. Without this, a stale-tagged player could sit nearer the attacker
    # and steal the @n lookup — teleporting the wrong person. These tags must never outlive a run.
    tag @a[tag=im.reversal_target] remove im.reversal_target
    tag @a[tag=im.reversal_done] remove im.reversal_done

    # Mark this defender so the attacker-frame step functions can teleport them across the context
    # switch. (No execute relation leads attacker -> defender when the attacker is a player, so a
    # tag is the only reliable bridge back to the exact person who blocked.)
    tag @s add im.reversal_target


# Enter the attacker's frame: their feet, their yaw with a flattened pitch (so the backward
# steps stay horizontal and never clip up or down), then walk the spots behind them.
execute on attacker at @s rotated ~ 0 run function imperium:enchantments/reversal_step1

# Flavor — outcome is known via the im.reversal_done tag. On success the command position is
    # still the ORIGIN (pre-teleport spot) and "at @s" is the DESTINATION, so you can split the
    # departure and arrival effects. Swap these examples for your own sound/particles.
    execute if entity @s[tag=im.reversal_done] run particle minecraft:effect{color:6234567} ~ ~ ~ 0.3 1 0.3 1 100
    execute if entity @s[tag=im.reversal_done] at @s run particle minecraft:reverse_portal ~ ~1 ~ 0.3 0.6 0.3 0.05 30
    execute if entity @s[tag=im.reversal_done] at @s run playsound minecraft:entity.enderman.teleport player @a ~ ~ ~ 1 1.5

    # Failure (every spot blocked, or no attacker) — position is the blocker, who did not move.
    execute unless entity @s[tag=im.reversal_done] run playsound minecraft:entity.shulker.hurt player @s ~ ~ ~ 1 0.6

# Spend 10 of the shield's 30 durability, but only if the warp actually happened.
execute if entity @s[tag=im.reversal_done] run \
    item modify entity @s weapon.offhand imperium:consume_10_durability

tag @s remove im.reversal_target
tag @s remove im.reversal_done
