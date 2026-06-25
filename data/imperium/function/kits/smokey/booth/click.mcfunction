# Booth kit-stand click — advancement-driven (fires from imperium:booth/select_smokey when a
# player right-clicks the smokey stand's interaction entity). Runs AS the exact clicker, so no
# UUID matching is needed. Re-arm the advancement, then route by sneak state.
advancement revoke @s only imperium:booth/select_smokey
execute if predicate imperium:sneaking run function imperium:kits/smokey/booth/lore
execute unless predicate imperium:sneaking run function imperium:kits/smokey/booth/select
