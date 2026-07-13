# Clear-kit stand click — advancement-driven (imperium:booth/select_clear), runs as the
# exact clicker. Sneak = describe, click = clear.
advancement revoke @s only imperium:booth/select_clear
execute if predicate imperium:sneaking run return run tellraw @s {text:" Clear Kit — hand back your items and reset your battlegrounds kit to default.",color:"gray"}
function imperium:booth/clear/select
