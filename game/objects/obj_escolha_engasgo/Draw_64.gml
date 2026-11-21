if (global.missao != 2 || global.dialogo_ativo || global.minigame_engasgo)
{
    exit;
}

draw_set_color(c_black);
draw_set_alpha(0.88);
draw_rectangle(250, 450, 1050, 680, false);
draw_set_alpha(1);

draw_set_color(c_white);
tcc_draw_text(290, 475, "O aluno esta engasgado. O que voce faz?");

draw_set_color(c_yellow);
tcc_draw_text(310, 530, "1 - Dar agua");
tcc_draw_text(310, 575, "2 - Fazer a manobra de desengasgo");
tcc_draw_text(310, 620, "3 - Deitar o aluno");

draw_set_color(c_white);
tcc_draw_text(310, 655, "Aperte 1, 2 ou 3");