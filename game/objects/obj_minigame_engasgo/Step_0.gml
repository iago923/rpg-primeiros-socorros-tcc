global.progresso_engasgo = max(0, global.progresso_engasgo - 0.08);
global.tempo_engasgo--;

if (keyboard_check_pressed(vk_space)||tcc_touch_pressed(vk_space)) {
    global.progresso_engasgo = min(100, global.progresso_engasgo + 25);
}

if (global.progresso_engasgo >= 100) {
    global.minigame_engasgo = false;
    global.xp += 50;
    global.missao = 3;
    global.nome_missao = "Volte para a professora";
    global.dialogo_titulo = "Muito bem!";
    global.dialogo_texto = "O aluno voltou a respirar. Leve a situacao para a professora.";
    global.dialogo_pode_fechar = 8;
    global.dialogo_ativo = true;
    instance_destroy();
    exit;
}

if (global.tempo_engasgo <= 0) {
    global.tempo_engasgo = 60 * 7;
    global.progresso_engasgo = max(35, global.progresso_engasgo);
}
