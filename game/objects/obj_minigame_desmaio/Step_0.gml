var velocidade = 2.5 + (acertos * 0.7);

marcador += velocidade * direcao;

if (marcador >= 100)
{
    marcador = 100;
    direcao = -1;
}

if (marcador <= 0)
{
    marcador = 0;
    direcao = 1;
}

if (keyboard_check_pressed(vk_space)||tcc_touch_pressed(vk_space))
{
    if (marcador >= 42 && marcador <= 58)
    {
        acertos++;
        mensagem = "BOA VERIFICACAO!";

        if (acertos >= 3)
        {
            global.minigame_desmaio = false;
            global.xp += 60;
            global.missao = 6;
            global.nome_missao = "Volte para a professora";

            global.dialogo_titulo = "Atendimento concluido!";
            global.dialogo_texto = "Voce verificou a respiracao e pediu ajuda.";
            global.dialogo_pode_fechar = 8;
            global.dialogo_ativo = true;

            instance_destroy();
        }
    }
    else
    {
        vidas--;
        mensagem = "FORA DA FAIXA!";

        if (vidas <= 0)
        {
            vidas = 3;
            acertos = 0;
            mensagem = "RECOMECANDO...";
        }
    }
}
