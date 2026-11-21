var barra_x = 390;
var barra_y = 470;
var largura = 500;
var preenchimento = largura * global.progresso_engasgo / 100;

draw_set_color(c_black);
draw_set_alpha(0.86);
draw_rectangle(300, 380, 980, 590, false);
draw_set_alpha(1);

draw_set_color(c_white);
tcc_draw_text(390, 405, "MANOBRA DE DESENGASGO");
tcc_draw_text(390, 435, "APERTE ESPACO E MANTENHA O RITMO");

draw_set_color(c_dkgray);
draw_rectangle(barra_x, barra_y, barra_x + largura, barra_y + 30, false);

if (global.progresso_engasgo < 40)
    draw_set_color(c_red);
else if (global.progresso_engasgo < 75)
    draw_set_color(c_yellow);
else
    draw_set_color(c_lime);

draw_rectangle(barra_x, barra_y, barra_x + preenchimento, barra_y + 30, false);

draw_set_color(c_white);
tcc_draw_text(390, 525, "Tempo: " + string(ceil(global.tempo_engasgo / room_speed)));