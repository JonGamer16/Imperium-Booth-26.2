# Runs as any entity (player or mob) carrying Bad Omen from a Marking Dart hit. Bad Omen is only the on-hit
# signal (vanilla has no native "arrow applied a tag"); convert it to the tracked im.marked
# tag with a 10s (200t) timer, then strip the effect so tracking is purely tag-based.
# Re-hits re-run this and refresh the timer.
tag @s add im.marked
scoreboard players set @s im_markTimer 200
effect clear @s minecraft:bad_omen
