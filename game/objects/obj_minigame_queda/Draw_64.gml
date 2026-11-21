draw_set_color(c_black);
draw_set_alpha(0.88);
draw_rectangle(300, 360, 980, 630, false);
draw_set_alpha(1);

draw_set_color(c_white);
tcc_draw_text(390, 390, "ESTABILIZE O ALUNO");
tcc_draw_text(390, 420, aviso);

for (var i = 0; i < 4; i++)
{
    var seta = "";

    switch (sequencia[i])
    {
        case 0: seta = "<"; break;
        case 1: seta = "^"; break;
        case 2: seta = ">"; break;
        case 3: seta = "V"; break;
    }

    if (i < etapa)
        draw_set_color(c_lime);
    else
        draw_set_color(c_white);

    draw_rectangle(400 + i * 95, 470, 470 + i * 95, 530, true);
    tcc_draw_text(425 + i * 95, 490, seta);
}

draw_set_color(c_white);
tcc_draw_text(390, 570, "Tentativas: " + string(vidas));
tcc_draw_text(390, 595, "Tempo: " + string(ceil(tempo / room_speed)));