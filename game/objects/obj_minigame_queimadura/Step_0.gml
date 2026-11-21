tempo--;

var apertou = false;
var acertou = false;

if (keyboard_check_pressed(ord("A")))
{
    apertou = true;
    acertou = (tecla_atual == 0);
}

if (keyboard_check_pressed(ord("D")))
{
    apertou = true;
    acertou = (tecla_atual == 1);
}

if (keyboard_check_pressed(ord("W")))
{
    apertou = true;
    acertou = (tecla_atual == 2);
}

if (keyboard_check_pressed(ord("S")))
{
    apertou = true;
    acertou = (tecla_atual == 3);
}

if (keyboard_check_pressed(vk_space)||tcc_touch_pressed(vk_space))
{
    apertou = true;
    acertou = (tecla_atual == 4);
}

if (apertou)
{
    if (acertou)
    {
        audio_play_sound(snd_acerto, 1, false);

        acertos++;
        tecla_atual = irandom(4);
        aviso = "BOA! CONTINUE RESFRIANDO.";
    }
    else
    {
        audio_play_sound(snd_erro, 1, false);

        erros++;
        aviso = "TECLA ERRADA!";
    }
}

if (acertos >= 7)
{
    global.minigame_queimadura = false;
    global.xp += 60;
    global.missao = 9;
    global.nome_missao = "Volte para a professora";

    global.dialogo_titulo = "Queimadura resfriada!";
    global.dialogo_texto = "Agora o aluno deve receber avaliacao medica.";
    global.dialogo_pode_fechar = 8;
    global.dialogo_ativo = true;

    audio_play_sound(snd_acerto, 1, false);
    instance_destroy();
}

if (tempo <= 0)
{
    tempo = room_speed * 12;
    acertos = 0;
    erros = 0;
    tecla_atual = irandom(4);
    aviso = "RECOMECE E SIGA AS TECLAS.";
}
