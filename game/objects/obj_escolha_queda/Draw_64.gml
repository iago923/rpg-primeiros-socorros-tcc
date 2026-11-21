if (global.missao != 11 || global.dialogo_ativo)
{
    exit;
}

draw_set_color(c_black);
draw_set_alpha(0.88);
draw_rectangle(250, 450, 1050, 680, false);
draw_set_alpha(1);

draw_set_color(c_white);
tcc_draw_text(290, 475, "O aluno caiu e sente dor na perna. O que voce faz?");

draw_set_color(c_yellow);
tcc_draw_text(310, 530, "1 - Tentar colocar a perna no lugar");
tcc_draw_text(310, 575, "2 - Manter parado, pedir ajuda e estabilizar");
tcc_draw_text(310, 620, "3 - Mandar o aluno caminhar");

draw_set_color(c_white);
tcc_draw_text(310, 655, "Aperte 1, 2 ou 3");