# Random-kit stand click — advancement-driven (imperium:booth/select_random), runs as the
# exact clicker. Sneak = describe, click = roll.
advancement revoke @s only imperium:booth/select_random
execute if predicate imperium:sneaking run return run tellraw @s {text:" Random Kit — try your luck with one of the seven fighters.",color:"gray"}
function imperium:booth/random/select
