var ativo = room == rm_enfermaria;
if (ativo) {
    draw_sprite_ext(spr_cartaz_socorros, 0, x, y - 12, 0.52, 0.52, 0, c_white, 1);
}
if (ativo && distance_to_object(obj_player) < 48 && !global.dialogo_ativo) {
    draw_set_halign(fa_center);
    draw_set_color(c_yellow);
    tcc_draw_text(x, y - 42, "E");
    draw_set_halign(fa_left);
}
