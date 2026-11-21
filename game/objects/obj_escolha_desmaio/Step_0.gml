if (global.missao != 5 || global.dialogo_ativo || global.minigame_desmaio)
{
    exit;
}

if (keyboard_check_pressed(ord("1")))
{
    global.dialogo_titulo = "Nao faca isso!";
    global.dialogo_texto = "Nao de agua para alguem desacordado.";
    global.dialogo_ativo = true;
}

if (keyboard_check_pressed(ord("2")))
{
    global.minigame_desmaio = true;

    instance_create_layer(0, 0, "Instances", obj_minigame_desmaio);
    instance_destroy();
}

if (keyboard_check_pressed(ord("3")))
{
    global.dialogo_titulo = "Cuidado!";
    global.dialogo_texto = "Nao levante o aluno rapidamente.";
    global.dialogo_ativo = true;
}