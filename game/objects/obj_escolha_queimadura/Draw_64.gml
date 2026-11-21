if (global.missao != 8 || global.dialogo_ativo)
{
    exit;
}

draw_set_color(c_black);
draw_set_alpha(0.88);
draw_rectangle(250, 450, 1050, 680, false);
draw_set_alpha(1);

draw_set_color(c_white);
tcc_draw_text(290, 475, "O aluno sofreu uma queimadura. O que voce faz?");

draw_set_color(c_yellow);
tcc_draw_text(310, 530, "1 - Colocar gelo");
tcc_draw_text(310, 575, "2 - Resfriar com agua corrente");
tcc_draw_text(310, 620, "3 - Passar pasta de dente");

draw_set_color(c_white);
tcc_draw_text(310, 655, "Aperte 1, 2 ou 3");