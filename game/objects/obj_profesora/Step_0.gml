depth=-y;
if(tcc_modal())exit;
if (distance_to_object(obj_player)<62 && (keyboard_check_pressed(ord("E"))||tcc_touch_pressed(ord("E"))) && !global.dialogo_ativo) {
    audio_play_sound(snd_interagir,1,false);
    global.dialogo_titulo="Professora Ana";
    switch(global.missao) {
        case 0:
            tcc_concluir("apresentacao");
            global.missao=100; global.nome_missao="Va ao centro de treinamento";
            global.dialogo_texto="Antes das ocorrencias, conclua sua capacitacao. Saia pela porta de baixo, contorne a secretaria pelo corredor da direita e siga para cima. A porta TREINAMENTO fica acima da secretaria. Aperte E perto dela.";
        break;
        case 110:
            global.missao=1; global.nome_missao="Atenda o aluno na cantina";
            global.dialogo_texto="Etapas de estudo concluídas. Sua primeira ocorrencia real esta na cantina. Observe, mantenha a calma e aplique o que aprendeu.";
        break;
        case 3:
            global.missao=4; global.nome_missao="Encontre o grupo na quadra";
            global.dialogo_texto="O colega da cantina está acompanhado. Obrigada por pedir ajuda. Na quadra, uma colega parou de responder; o professor chamou apoio. Vá até ele. Sua bolsa continua com você: observar e pedir ajuda não gastam materiais.";
        break;
        case 6:
            global.missao=7; global.nome_missao="Converse com o grupo no laboratório";
            global.dialogo_texto="A colega ficou com o professor e a equipe de atendimento. Agora o laboratório pediu apoio após um acidente com um recipiente quente. Leve a mesma bolsa. Se faltar cobertura, o funcionário traz: não deixe a pessoa sozinha para buscar material.";
        break;
        case 9:
            global.missao=10; global.nome_missao="Encontre Rafa no corredor";
            global.dialogo_texto="O funcionário está acompanhando o colega do laboratório. Rafa precisa de ajuda no corredor: alguém caiu e sente dor nas costas. Sua prioridade é observar e chamar apoio, não procurar outro kit.";
        break;
        case 12:
            tcc_concluir("encerramento");
            global.jogo_finalizado=true; global.nome_missao="Aprendizagem: continue praticando";
            global.dialogo_ativo=false; audio_play_sound(snd_vitoria,1,false);
            instance_create_layer(0,0,"Instances",obj_tela_final); exit;
        break;
        default:
            global.dialogo_texto="Conclua o objetivo indicado no painel e depois volte para conversarmos.";
        break;
    }
    global.tcc_dirty=true;global.dialogo_pode_fechar=8; global.dialogo_ativo=true;
}
