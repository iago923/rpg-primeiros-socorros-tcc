if (global.missao != 2 || global.dialogo_ativo || global.minigame_engasgo)
{
    exit;
}

if (keyboard_check_pressed(ord("1")))
{
    global.dialogo_titulo = "Nao!";
    global.dialogo_texto = "Nao ofereca agua para uma pessoa engasgada.";
    global.dialogo_ativo = true;
}

if (keyboard_check_pressed(ord("2")))
{
    global.minigame_engasgo = true;
    global.progresso_engasgo = 45;
    global.tempo_engasgo = room_speed * 7;

    instance_create_layer(0, 0, "Instances", obj_minigame_engasgo);
    instance_destroy();
}

if (keyboard_check_pressed(ord("3")))
{
    global.dialogo_titulo = "Cuidado!";
    global.dialogo_texto = "Deitar a pessoa nao resolve o engasgo.";
    global.dialogo_ativo = true;
}