if (global.missao != 7 && global.missao != 8) exit;

draw_set_alpha(0.18);
draw_set_color(c_black);
draw_ellipse(x-12,y-4,x+12,y+3,false);
draw_set_alpha(1);
draw_set_color(c_white);
draw_self();
if(is_struct(global.tcc_case)&&global.tcc_case.topic==3&&global.tcc_case.consumed){
 draw_set_color(c_white);draw_rectangle(x+4*image_xscale,y-47*image_yscale,x+11*image_xscale,y-40*image_yscale,false);draw_set_color(c_white);
}
draw_set_halign(fa_center);
draw_set_color(c_red);
tcc_draw_text(x, y - 48, "!");
if (distance_to_object(obj_player) < 55 && !global.dialogo_ativo) {
    draw_set_color(c_white);
    tcc_draw_text(x, y - 66, "E");
}
draw_set_halign(fa_left);
