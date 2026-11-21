if(global.dialogo_ativo){
 tcc_frame(80,450,1120,210);draw_set_font(global.font_body);draw_set_color(make_color_rgb(25,65,53));
 tcc_draw_text(108,470,global.dialogo_titulo);tcc_text(108,512,global.dialogo_texto,1055);
 tcc_draw_text(1040,628,"Espaço >");draw_set_font(-1);draw_set_color(c_white);
}
