if (global.missao != 5 || global.dialogo_ativo || global.minigame_desmaio)
{
    exit;
}

draw_set_color(c_black);
draw_set_alpha(0.88);
draw_rectangle(250, 450, 1050, 680, false);
draw_set_alpha(1);

draw_set_color(c_white);
tcc_draw_text(290, 475, "O aluno esta desacordado. O que voce faz?");

draw_set_color(c_yellow);
tcc_draw_text(310, 530, "1 - Dar agua");
tcc_draw_text(310, 575, "2 - Verificar resposta e respiracao");
tcc_draw_text(310, 620, "3 - Levantar o aluno");

draw_set_color(c_white);
tcc_draw_text(310, 655, "Aperte 1, 2 ou 3");