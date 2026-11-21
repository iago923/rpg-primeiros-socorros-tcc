var comando = "";

switch (tecla_atual)
{
    case 0: comando = "A"; break;
    case 1: comando = "D"; break;
    case 2: comando = "W"; break;
    case 3: comando = "S"; break;
    case 4: comando = "ESPACO"; break;
}

draw_set_color(c_black);
draw_set_alpha(0.88);
draw_rectangle(300, 360, 980, 630, false);
draw_set_alpha(1);

draw_set_color(c_white);
tcc_draw_text(390, 390, "RESFRIE A QUEIMADURA");
tcc_draw_text(390, 420, aviso);

draw_set_color(c_blue);
draw_rectangle(555, 465, 730, 540, false);

draw_set_color(c_white);
tcc_draw_text(590, 490, comando);

tcc_draw_text(390, 575, "Acertos: " + string(acertos) + "/7");
tcc_draw_text(390, 600, "Tempo: " + string(ceil(tempo / room_speed)));