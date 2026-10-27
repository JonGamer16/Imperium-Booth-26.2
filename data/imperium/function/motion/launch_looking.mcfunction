# Launch @s by $strength im.motion along the execution rotation. Shorthand for get_looking +
# launch_xyz; overwrites $x / $y / $z im.motion.
function imperium:motion/get_looking
return run function imperium:motion/launch_xyz
