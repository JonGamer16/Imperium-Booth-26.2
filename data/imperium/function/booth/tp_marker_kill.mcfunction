# Teardown half of the #summit.booth:imperium/entities/kill hook (paired with tp_marker_summon via
# reset_tp_markers). Kills EVERY marker carrying each warp tag, not just the nearest one within a
# block: @n kills at most one, so a duplicate pair — from a double booth load, a manual re-run, or a
# /reload — could never be cleaned up and would stack warp markers on the same spot forever.
# Both tags are created only by imperium:booth/tp_marker_summon, so matching them globally is safe.
# `in overworld` keeps this dimension-explicit no matter where the hook is fired from.
execute in overworld run kill @e[type=marker,tag=im.warp_from_kitroom]
execute in overworld run kill @e[type=marker,tag=im.warp_from_shulkerbox]