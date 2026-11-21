if (global.dialogo_ativo)
{
    if (global.dialogo_pode_fechar > 0)
    {
        global.dialogo_pode_fechar--;
    }
    else if (keyboard_check_pressed(vk_space)||tcc_touch_pressed(vk_space))
    {
        global.dialogo_ativo = false;
    }
}
