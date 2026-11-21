if (global.missao != 8 || global.dialogo_ativo)
{
    exit;
}

if (keyboard_check_pressed(ord("1")))
{
    audio_play_sound(snd_erro, 1, false);

    global.dialogo_titulo = "Nao!";
    global.dialogo_texto = "Nao use gelo diretamente na queimadura.";
    global.dialogo_ativo = true;
}

if (keyboard_check_pressed(ord("2")))
{
    global.minigame_queimadura = true;

    instance_create_layer(0, 0, "Instances", obj_minigame_queimadura);
    instance_destroy();
}

if (keyboard_check_pressed(ord("3")))
{
    audio_play_sound(snd_erro, 1, false);

    global.dialogo_titulo = "Nao!";
    global.dialogo_texto = "Nao use pasta de dente nem produtos caseiros.";
    global.dialogo_ativo = true;
}