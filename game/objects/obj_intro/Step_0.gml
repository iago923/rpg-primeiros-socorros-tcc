if (keyboard_check_pressed(vk_space)||tcc_touch_pressed(vk_space))
{
    pagina++;

    if (pagina >= 4)
    {
        global.intro_ativo = false;
        global.tcc_dirty = true;
        instance_destroy();
    }
}
