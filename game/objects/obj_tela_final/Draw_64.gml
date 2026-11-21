var largura = display_get_gui_width();
var altura = display_get_gui_height();
var ranking = "RESGATISTA BRONZE";

if (global.xp >= 170)
    ranking = "RESGATISTA OURO";
else if (global.xp >= 120)
    ranking = "RESGATISTA PRATA";

draw_set_color(make_color_rgb(15, 29, 42));
draw_set_alpha(0.96);
draw_rectangle(0, 0, largura, altura, false);
draw_set_alpha(1);

for (var i = 0; i < 55; i++)
{
    var cor = c_yellow;

    if (i mod 3 == 1)
        cor = c_aqua;

    if (i mod 3 == 2)
        cor = c_lime;

    draw_set_color(cor);
    draw_circle(confete_x[i], (confete_y[i] + tempo_final * confete_vel[i]) mod altura, 4, false);
}

draw_set_halign(fa_center);

draw_set_color(c_yellow);
tcc_draw_text(largura / 2, 170, "MISSAO CONCLUIDA!");

draw_set_color(c_white);
tcc_draw_text(largura / 2, 230, "Voce concluiu todos os atendimentos de primeiros socorros.");
tcc_draw_text(largura / 2, 280, "Pontuacao final: " + string(global.xp) + " XP");

draw_set_color(c_aqua);
tcc_draw_text(largura / 2, 345, ranking);

draw_set_color(c_white);
tcc_draw_text(largura / 2, 455, "Engasgo  |  Desmaio  |  Queimadura  |  Queda");
tcc_draw_text(largura / 2, 535, "Pressione R para jogar novamente");

draw_set_halign(fa_left);