var barra_x = 390;
var barra_y = 480;
var largura = 500;
var pos_marcador = barra_x + (marcador / 100) * largura;

draw_set_color(c_black);
draw_set_alpha(0.86);
draw_rectangle(300, 380, 980, 610, false);
draw_set_alpha(1);

draw_set_color(c_white);
tcc_draw_text(390, 405, "VERIFIQUE A RESPIRACAO");
tcc_draw_text(390, 435, mensagem);

draw_set_color(c_dkgray);
draw_rectangle(barra_x, barra_y, barra_x + largura, barra_y + 30, false);

draw_set_color(c_green);
draw_rectangle(barra_x + 210, barra_y, barra_x + 290, barra_y + 30, false);

draw_set_color(c_white);
draw_rectangle(pos_marcador - 4, barra_y - 8, pos_marcador + 4, barra_y + 38, false);

tcc_draw_text(390, 535, "Acertos: " + string(acertos) + "/3");
tcc_draw_text(390, 565, "Tentativas: " + string(vidas));