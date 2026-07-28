# Macro (called from dmg_show with the husk as executor/position): summon the floating red number
# 2.4 blocks above the husk. billboard=center faces every viewer; see_through so it reads even
# through the husk/gear. Tagged im.dmg_new (armed by dmg_show) + im.dmg_ind (aged in loop_tick).
$summon text_display ~ ~2.4 ~ {Tags:["im.dmg_ind","im.dmg_new","summit.booth_entity.imperium"],billboard:"center",alignment:"center",see_through:true,text:{text:"-$(whole).$(frac)",color:"red",bold:true},transformation:{scale:[1.4f,1.4f,1.4f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f]}}
