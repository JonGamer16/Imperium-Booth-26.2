# A thrown web potion just landed as an area_effect_cloud at ~ ~ ~ (this runs AS that cloud, at its
# position). Replace the courier cloud with the real web — a cobweb block display centered on the
# landing spot — then remove the cloud. The display IS the web: it carries the lifetime and area.
summon block_display ~ ~ ~ {Tags:["im.web","im.web_new"],block_state:{Name:"minecraft:cobweb"},transformation:{translation:[-0.5f,0f,-0.5f],scale:[1f,1f,1f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f]}}

# Seed the new web's lifetime (#WebDuration ticks); the loop ticks im_webLife down and kills it at 0.
scoreboard players operation @e[tag=im.web_new] im_webLife = #WebDuration im.param
tag @e[tag=im.web_new] remove im.web_new

# Courier cloud has done its job — remove it so it can't re-trigger or apply its filler effect.
kill @s
