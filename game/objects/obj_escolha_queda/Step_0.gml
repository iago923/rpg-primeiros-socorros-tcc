if (global.missao != 11 || global.dialogo_ativo)
{
    exit;
}

if (keyboard_check_pressed(ord("1")))
{
    audio_play_sound(snd_erro, 1, false);

    global.dialogo_titulo = "Cuidado!";
    global.dialogo_texto = "Nao tente colocar o membro na posicao a forca.";
    global.dialogo_ativo = true;
}

if (keyboard_check_pressed(ord("2")))
{
    global.minigame_queda = true;

    instance_create_layer(0, 0, "Instances", obj_minigame_queda);
    instance_destroy();
}

if (keyboard_check_pressed(ord("3")))
{
    audio_play_sound(snd_erro, 1, false);

    global.dialogo_titulo = "Nao!";
    global.dialogo_texto = "Nao obrigue o aluno a levantar e caminhar.";
    global.dialogo_ativo = true;
}