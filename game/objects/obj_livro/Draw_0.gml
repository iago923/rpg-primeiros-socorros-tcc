if (distance_to_object(obj_player) < 40 && !global.dialogo_ativo) {
    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(82, 214, 173));
    tcc_draw_text(x, y - 25, "E");
    draw_set_halign(fa_left);
}
