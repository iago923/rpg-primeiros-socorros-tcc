tempo--;

var entrada = -1;

if (keyboard_check_pressed(vk_left))  entrada = 0;
if (keyboard_check_pressed(vk_up))    entrada = 1;
if (keyboard_check_pressed(vk_right)) entrada = 2;
if (keyboard_check_pressed(vk_down))  entrada = 3;

if (entrada != -1)
{
    if (entrada == sequencia[etapa])
    {
        audio_play_sound(snd_acerto, 1, false);

        etapa++;
        aviso = "CERTO!";

        if (etapa >= 4)
        {
            global.minigame_queda = false;
            global.xp += 60;
            global.missao = 12;
            global.nome_missao = "Volte para a professora";

            global.dialogo_titulo = "Aluno estabilizado!";
            global.dialogo_texto = "Voce evitou movimentar o aluno e pediu ajuda.";
            global.dialogo_pode_fechar = 8;
            global.dialogo_ativo = true;

            audio_play_sound(snd_acerto, 1, false);
            instance_destroy();
        }
    }
    else
    {
        audio_play_sound(snd_erro, 1, false);

        vidas--;
        etapa = 0;
        sequencia = [irandom(3), irandom(3), irandom(3), irandom(3)];
        aviso = "ERROU! NOVA SEQUENCIA.";

        if (vidas <= 0)
        {
            vidas = 3;
        }
    }
}

if (tempo <= 0)
{
    tempo = room_speed * 12;
    etapa = 0;
    vidas = 3;
    sequencia = [irandom(3), irandom(3), irandom(3), irandom(3)];
    aviso = "RECOMECANDO...";
}