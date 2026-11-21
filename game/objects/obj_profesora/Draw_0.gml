draw_set_alpha(0.18);
draw_set_color(c_black);
draw_ellipse(x-12,y-4,x+12,y+3,false);
draw_set_alpha(1);
draw_set_color(c_white);
draw_self();

if (distance_to_object(obj_player) < 48 && !global.dialogo_ativo)
{
    draw_set_color(c_white);
    tcc_draw_text(x - 28, y - 36, "E");
}