# Booth kit-stand click — advancement-driven (fires from imperium:booth/select_mummy when a
# player right-clicks the mummy stand's interaction entity). Runs AS the exact clicker, so no
# UUID matching is needed. Re-arm the advancement, then route by sneak state.
advancement revoke @s only imperium:booth/select_mummy
execute if predicate imperium:sneaking run function imperium:kits/mummy/booth/lore
execute unless predicate imperium:sneaking run function imperium:kits/mummy/booth/select
