    # Charge Attack (Levent): charge = idle ticks since the last rod jab OR shield raise. A jab
    # (Charge Attack enchant's post_piercing_attack -> charge_spend, fires on hit AND whiff) and a
    # shield raise (levent_shield -> charge_block) both zero it. At >= #LeventCharge the boost arms;
    # the next jab spends it and charge_off strips the bonus the following tick — so a whiff wastes
    # the charge. Mirrors Rastus's Strike.
    scoreboard players add @s im_leventCharge 1
    execute \
        as @s[tag=!im.levent_charged] \
        if score @s im_leventCharge >= #LeventCharge im.param \
        run function imperium:kits/levent/charge_on
    execute \
        as @s[tag=im.levent_charged] \
        unless score @s im_leventCharge >= #LeventCharge im.param \
        run function imperium:kits/levent/charge_off