if (variable_global_exists("introducao_vista") && global.introducao_vista) {
    instance_destroy();
    exit;
}
global.introducao_vista = true;
pagina = 0;
global.intro_ativo = true;