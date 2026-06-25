# Booth kit-stand click — advancement-driven (fires from imperium:booth/select_livvy when a
# player right-clicks the livvy stand's interaction entity). Runs AS the exact clicker, so no
# UUID matching is needed. Re-arm the advancement, then route by sneak state.
advancement revoke @s only imperium:booth/select_livvy
execute if predicate imperium:sneaking run function imperium:kits/livvy/booth/lore
execute unless predicate imperium:sneaking run function imperium:kits/livvy/booth/select
