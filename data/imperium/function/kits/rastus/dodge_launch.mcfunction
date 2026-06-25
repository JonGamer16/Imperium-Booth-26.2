# Pick the lateral dodge direction from the held movement keys and launch.
# Runs as/at the player; $strength player_motion.api.launch must be set by the caller.
#
# launch_looking fires along the execution rotation, so we rotate by a yaw offset relative
# to the player's facing (~) with pitch pinned to 0 (horizontal only). Offsets: forward 0,
# right +90, backward 180, left -90; diagonals interpolate. Diagonals (two keys held) are
# checked before cardinals so the first matching branch wins via `return`.

# --- Diagonals ---
execute \
    if predicate player_input:forward \
    if predicate player_input:right \
    rotated ~45 0 \
    run return run function player_motion:api/launch_looking
execute \
    if predicate player_input:forward \
    if predicate player_input:left \
    rotated ~-45 0 \
    run return run function player_motion:api/launch_looking
execute \
    if predicate player_input:backward \
    if predicate player_input:right \
    rotated ~135 0 \
    run return run function player_motion:api/launch_looking
execute \
    if predicate player_input:backward \
    if predicate player_input:left \
    rotated ~-135 0 \
    run return run function player_motion:api/launch_looking

# --- Cardinals ---
execute \
    if predicate player_input:forward \
    rotated ~0 0 \
    run return run function player_motion:api/launch_looking
execute \
    if predicate player_input:backward \
    rotated ~180 0 \
    run return run function player_motion:api/launch_looking
execute \
    if predicate player_input:right \
    rotated ~90 0 \
    run return run function player_motion:api/launch_looking
execute \
    if predicate player_input:left \
    rotated ~-90 0 \
    run return run function player_motion:api/launch_looking
