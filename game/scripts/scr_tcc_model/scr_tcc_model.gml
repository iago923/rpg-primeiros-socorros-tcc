function tcc_catalogo() {
    return [
        {id:"kit",nome:"Pacote de reposição antigo",desc:"Pacote de um save anterior: 2 luvas, 2 gazes e 1 cobertura. Não é sua bolsa, que permanece com você.",icone:spr_cartaz_socorros,maximo:1,consumivel:true,categoria:"Reposição",usos:[]},
        {id:"luvas",nome:"Luvas descartáveis",desc:"Material preservado do save anterior. Nenhuma etapa atual exige seu uso. Pode ficar no armário; não é a cobertura indicada nesta atividade.",icone:spr_cartaz_socorros,maximo:4,consumivel:true,categoria:"Reserva",usos:[]},
        {id:"gaze",nome:"Gaze limpa",desc:"Reserva do save anterior, sem ação exigida nesta campanha. Guarde no armário. Nesta queimadura usamos a cobertura não aderente, não gaze comum.",icone:spr_cartaz_socorros,maximo:6,consumivel:true,categoria:"Reserva",usos:[]},
        {id:"cobertura",nome:"Cobertura não aderente",desc:"Para proteger uma queimadura após resfriar, sem apertar, conforme orientação.",icone:spr_cartaz_socorros,maximo:4,consumivel:true,categoria:"Material",usos:["queimadura"]},
        {id:"manta",nome:"Manta reutilizável",desc:"Reserva do save anterior. Não é necessária nas etapas atuais; pode ser guardada no armário. Não substitui a cobertura não aderente.",icone:spr_cartaz_socorros,maximo:1,consumivel:false,categoria:"Reutilizável",usos:["conforto"]},
        {id:"bolsa",nome:"Estojo médico",desc:"Recipiente para organizar materiais. Não é um pacote de consumíveis.",icone:spr_livro,maximo:1,consumivel:false,categoria:"Recipiente",usos:[]}
    ];
}
function tcc_item(_id){var cat=tcc_catalogo();for(var i=0;i<array_length(cat);i++)if(cat[i].id==_id)return cat[i];return undefined;}
function tcc_lista_array(_list){var a=[];for(var i=0;i<ds_list_size(_list);i++){var e=_list[|i];array_push(a,{item_id:e.item_id,quantity:e.quantity,slot:e.slot,state:e.state});}return a;}
function tcc_lista_commit(_list,_a){ds_list_clear(_list);for(var i=0;i<array_length(_a);i++){_a[i].slot=i;ds_list_add(_list,_a[i]);}}
function tcc_quantidade(_list,_id){var n=0;for(var i=0;i<ds_list_size(_list);i++)if(_list[|i].item_id==_id)n+=_list[|i].quantity;return n;}
function tcc_adicionar_array(_a,_id,_n,_cap){
    var item=tcc_item(_id);if(!is_struct(item)||!is_real(_n)||_n<=0||floor(_n)!=_n)return undefined;
    for(var i=0;i<array_length(_a);i++)if(_a[i].item_id==_id){var q=min(_n,item.maximo-_a[i].quantity);_a[i].quantity+=q;_n-=q;}
    while(_n>0){if(array_length(_a)>=_cap)return undefined;var q=min(_n,item.maximo);array_push(_a,{item_id:_id,quantity:q,slot:array_length(_a),state:"pronto"});_n-=q;}return _a;
}
function tcc_remover_array(_a,_id,_n){
    if(!is_real(_n)||_n<=0||floor(_n)!=_n)return undefined;
    for(var i=array_length(_a)-1;i>=0;i--)if(_a[i].item_id==_id){var q=min(_n,_a[i].quantity);_a[i].quantity-=q;_n-=q;if(_a[i].quantity==0)array_delete(_a,i,1);}
    return _n==0?_a:undefined;
}
function tcc_adicionar(_list,_id,_n,_cap){var a=tcc_adicionar_array(tcc_lista_array(_list),_id,_n,_cap);if(is_undefined(a))return false;tcc_lista_commit(_list,a);return true;}
function tcc_remover(_list,_id,_n){var a=tcc_remover_array(tcc_lista_array(_list),_id,_n);if(is_undefined(a))return false;tcc_lista_commit(_list,a);return true;}
function tcc_consumir(_id,_uso){
    var item=tcc_item(_id);if(!is_struct(item)||tcc_quantidade(global.bolsa,_id)<1)return false;
    var allowed=false;for(var i=0;i<array_length(item.usos);i++)if(item.usos[i]==_uso)allowed=true;
    if(!allowed)return false;
    if(!item.consumivel)return true;
    return tcc_remover(global.bolsa,_id,1);
}
function tcc_cabe(_list,_id,_n,_cap){return !is_undefined(tcc_adicionar_array(tcc_lista_array(_list),_id,_n,_cap));}
function tcc_abrir_kit(){
    var a=tcc_remover_array(tcc_lista_array(global.bolsa),"kit",1);if(is_undefined(a))return false;
    var ids=["luvas","gaze","cobertura"],q=[2,2,1];
    for(var i=0;i<3;i++){a=tcc_adicionar_array(a,ids[i],q[i],8);if(is_undefined(a))return false;}
    tcc_lista_commit(global.bolsa,a);global.tcc_dirty=true;return true;
}
function tcc_transferir(_origem,_destino,_index,_cap){
    if(_origem==_destino||_index<0||_index>=ds_list_size(_origem))return false;
    var e=_origem[|_index],a=tcc_adicionar_array(tcc_lista_array(_destino),e.item_id,e.quantity,_cap);
    if(is_undefined(a))return false;
    tcc_lista_commit(_destino,a);ds_list_delete(_origem,_index);tcc_lista_commit(_origem,tcc_lista_array(_origem));global.tcc_dirty=true;return true;
}
function tcc_reorganizar_lista(_list,_a,_b){if(_a<0||_b<0||_a>=ds_list_size(_list)||_b>=ds_list_size(_list))return false;var e=_list[|_a];_list[|_a]=_list[|_b];_list[|_b]=e;tcc_lista_commit(_list,tcc_lista_array(_list));global.tcc_dirty=true;return true;}
function tcc_reorganizar(_a,_b){return tcc_reorganizar_lista(global.bolsa,_a,_b);}
function tcc_concluir(_id){if(variable_struct_exists(global.progresso,_id))return false;variable_struct_set(global.progresso,_id,"concluida");global.xp+=10;global.tcc_dirty=true;return true;}
function tcc_principais(){return ["apresentacao","manual","avaliacao","treino_engasgo","estabilizacao","prova","engasgo","desmaio","queimadura","queda","encerramento"];}
function tcc_missoes(){
    return [
     {id:"apresentacao",responsavel:"Ana",objetivo:"O convite de Ana",requisitos:[],principal:true,recompensa:10,dialogo:"apresentacao"},
     {id:"manual",responsavel:"Ana",objetivo:"Primeiro, conhecer o cuidado",requisitos:["apresentacao"],principal:true,recompensa:10,dialogo:"manual"},
     {id:"avaliacao",responsavel:"Ana",objetivo:"Observar antes de agir",requisitos:["manual"],principal:true,recompensa:10,dialogo:"avaliacao"},
     {id:"treino_engasgo",responsavel:"Ana",objetivo:"Reconhecer o engasgo",requisitos:["avaliacao"],principal:true,recompensa:10,dialogo:"engasgo"},
     {id:"estabilizacao",responsavel:"Ana",objetivo:"Cuidado depois de uma queda",requisitos:["treino_engasgo"],principal:true,recompensa:10,dialogo:"queda"},
     {id:"prova",responsavel:"Ana",objetivo:"Revisar o que aprendemos",requisitos:["estabilizacao"],principal:true,recompensa:10,dialogo:"prova"},
     {id:"engasgo",responsavel:"Ana",objetivo:"Uma urgência na cantina",requisitos:["prova"],principal:true,recompensa:10,dialogo:"engasgo"},
     {id:"desmaio",responsavel:"Ana",objetivo:"Uma pausa na quadra",requisitos:["engasgo"],principal:true,recompensa:10,dialogo:"desmaio"},
     {id:"queimadura",responsavel:"Ana",objetivo:"O acidente no laboratório",requisitos:["desmaio"],principal:true,recompensa:10,dialogo:"queimadura"},
     {id:"queda",responsavel:"Ana",objetivo:"Abrir caminho para o socorro",requisitos:["queimadura"],principal:true,recompensa:10,dialogo:"queda"},
     {id:"encerramento",responsavel:"Ana",objetivo:"Continuar aprendendo",requisitos:["queda"],principal:true,recompensa:10,dialogo:"encerramento"},
     {id:"conversa_rafa",responsavel:"Rafa",objetivo:"Conhecer o apoio dos colegas",requisitos:[],principal:false,recompensa:10,dialogo:"conversa_rafa"},
     {id:"leitura_sala",responsavel:"Ana",objetivo:"Consultar o livro na sala",requisitos:[],principal:false,recompensa:10,dialogo:"seguranca"},
     {id:"organizar",responsavel:"Funcionário de apoio",objetivo:"Conferir e repor o armário",requisitos:[],principal:false,recompensa:10,dialogo:"reposicao"},
     {id:"conversa_bia",responsavel:"Bia",objetivo:"Conhecer os limites da simulação",requisitos:["apresentacao"],principal:false,recompensa:10,dialogo:"conversa_bia"}
    ];
}
function tcc_missao_estado(_missao){
    if(variable_struct_exists(global.progresso,_missao.id))return "concluida";
    for(var i=0;i<array_length(_missao.requisitos);i++)if(!variable_struct_exists(global.progresso,_missao.requisitos[i]))return "bloqueada";
    return "disponivel";
}
function tcc_percentual(){var ids=tcc_principais(),n=0;for(var i=0;i<array_length(ids);i++)if(variable_struct_exists(global.progresso,ids[i]))n++;return floor(100*n/array_length(ids));}
function tcc_migrar_missao(_missao){switch(_missao){case 31:return 4;case 61:return 7;case 91:return 10;}return _missao;}
function tcc_reset(){
    ds_list_clear(global.bolsa);ds_list_clear(global.armario);
    global.progresso={};global.aprendizagem={};global.mundo={};global.segundos=0;
    global.xp=0;global.missao=0;global.nome_missao="Converse com Ana na secretaria";
    global.introducao_vista=false;global.intro_ativo=false;global.dialogo_ativo=false;global.jogo_finalizado=false;
    global.conhecimento=0;global.avaliacao=0;global.tecnica_engasgo=0;global.estabilizacao=0;global.capacitado=false;
    global.itens_coletados=0;global.lore=0;global.sentado=false;global.minigame_engasgo=false;global.minigame_desmaio=false;
    global.spawn_x=1015;global.spawn_y=430;global.spawn_pendente=true;
    global.mundo.bolsa_obtida=true;global.mundo.ensino_versao=2;
    tcc_adicionar(global.bolsa,"cobertura",3,8);
    global.tcc_dirty=true;global.tcc_panel="";global.tcc_case=undefined;
}
function tcc_modal(){return global.tcc_panel!=""||global.dialogo_ativo||global.intro_ativo||global.tcc_input_lock>0||global.tcc_busy;}
function tcc_abrir(_panel){global.tcc_panel=_panel;global.tcc_focus=0;global.tcc_page=0;global.tcc_feedback="";global.tcc_input_lock=2;}
function tcc_fechar(){global.tcc_panel="";global.tcc_input_lock=2;}
function tcc_fala(_titulo,_texto){global.dialogo_titulo=_titulo;global.dialogo_texto=_texto;global.dialogo_ativo=true;global.dialogo_pode_fechar=10;}
function tcc_room_id(_id){return asset_get_index(_id);}
function tcc_snapshot(){
    global.mundo.atendimento=is_struct(global.tcc_case)?global.tcc_case:undefined;
    var facing="baixo";if(instance_exists(obj_player)){if(obj_player.sprite_index==spr_player_final_cima)facing="cima";if(obj_player.sprite_index==spr_player_final_direita)facing="direita";if(obj_player.sprite_index==spr_player_final_esquerda)facing="esquerda";}
    return {version:1,mission:global.missao,objective:global.nome_missao,xp:global.xp,seconds:global.segundos,
        room_id:room==rm_menu?"rm_hub":room_get_name(room),x:instance_exists(obj_player)?obj_player.x:1015,y:instance_exists(obj_player)?obj_player.y:430,facing:facing,
        bag:tcc_lista_array(global.bolsa),locker:tcc_lista_array(global.armario),progress:global.progresso,learning:global.aprendizagem,
        world:{intro:global.introducao_vista,conhecimento:global.conhecimento,avaliacao:global.avaliacao,engasgo:global.tecnica_engasgo,estabilizacao:global.estabilizacao,capacitado:global.capacitado,finalizado:global.jogo_finalizado,flags:global.mundo}};
}
function tcc_restaurar(_s){
    var target=tcc_room_id(_s.room_id);if(target<0||!tcc_checkpoint_livre(target,_s.x,_s.y)){global.tcc_notice="Checkpoint inválido; partida não carregada.";return false;}
    tcc_reset();tcc_lista_commit(global.bolsa,_s.bag);tcc_lista_commit(global.armario,_s.locker);
    global.missao=_s.mission;global.nome_missao=_s.objective;global.xp=_s.xp;global.segundos=_s.seconds;global.progresso=_s.progress;global.aprendizagem=_s.learning;
    global.mundo=_s.world.flags;global.introducao_vista=_s.world.intro;global.conhecimento=_s.world.conhecimento;global.avaliacao=_s.world.avaliacao;global.tecnica_engasgo=_s.world.engasgo;global.estabilizacao=_s.world.estabilizacao;global.capacitado=_s.world.capacitado;global.jogo_finalizado=_s.world.finalizado;
    global.mundo.bolsa_obtida=true;global.mundo.ensino_versao=2;
    global.missao=tcc_migrar_missao(global.missao);
    if(_s.mission!=global.missao)global.nome_missao=tcc_objetivo();
    if(variable_struct_exists(global.mundo,"atendimento")&&is_struct(global.mundo.atendimento)){
        global.tcc_case=global.mundo.atendimento;global.tcc_topic=global.tcc_case.topic;
        tcc_abrir(global.tcc_case.feedback!=""?"caso":"cena");
    }
    global.spawn_x=_s.x;global.spawn_y=_s.y;global.spawn_pendente=true;global.tcc_facing=_s.facing;global.tcc_dirty=false;room_goto(target);return true;
}
function tcc_web_read(_name){
    if(!file_exists(_name))return undefined;
    var _buffer=buffer_load(_name);if(_buffer<0)return undefined;
    var _text=buffer_read(_buffer,buffer_string);buffer_delete(_buffer);
    try{return json_parse(_text);}catch(_error){return undefined;}
}
function tcc_web_write(_name,_value){
    var _buffer=buffer_create(1,buffer_grow,1);
    buffer_write(_buffer,buffer_string,json_stringify(_value));
    buffer_save(_buffer,_name);buffer_delete(_buffer);
    return file_exists(_name);
}
function tcc_web_request(_path,_body){
    if(_path=="/settings"){
        if(variable_struct_exists(_body,"data")){
            if(!tcc_web_write("rpg_settings.sav",_body.data))return {ok:false,error:"Não foi possível salvar as configurações neste navegador."};
            return {ok:true,data:_body.data};
        }
        var _settings=tcc_web_read("rpg_settings.sav");
        return {ok:true,data:is_struct(_settings)?_settings:{music:0.2,sfx:0.25,large:false,reduced:true}};
    }
    if(_path=="/slots"){
        var _slots=[];
        for(var _i=1;_i<=3;_i++){
            var _name="rpg_slot_"+string(_i)+".sav",_save=tcc_web_read(_name);
            if(is_struct(_save)&&variable_struct_exists(_save,"version")&&variable_struct_exists(_save,"room_id"))array_push(_slots,{state:"ready",data:_save,updated:"Neste dispositivo"});
            else if(file_exists(_name))array_push(_slots,{state:"invalid"});
            else array_push(_slots,{state:"empty"});
        }
        return {ok:true,slots:_slots};
    }
    var _slot=clamp(real(_body.slot),1,3),_file="rpg_slot_"+string(_slot)+".sav";
    if(_path=="/save"){
        var _existing=tcc_web_read(_file);
        if(_body.new_game&&is_struct(_existing)&&!_body.overwrite)return {ok:false,error:"Este slot já contém uma partida."};
        if(is_struct(_existing)&&!tcc_web_write(_file+".bak",_existing))return {ok:false,error:"Não foi possível preservar a cópia anterior."};
        if(!tcc_web_write(_file,_body.data))return {ok:false,error:"O navegador não conseguiu guardar a partida."};
        return {ok:true};
    }
    if(_path=="/load"||_path=="/recover"){
        var _data=_path=="/recover"?tcc_web_read(_file+".bak"):tcc_web_read(_file);
        if(!is_struct(_data))return {ok:false,error:"Não há partida válida neste slot."};
        return {ok:true,data:_data};
    }
    return {ok:false,error:"Operação de salvamento desconhecida."};
}
function tcc_process_response(_response){
    global.tcc_busy=false;
    if(!is_struct(_response)||!variable_struct_exists(_response,"ok")||!_response.ok){
        global.tcc_new_pending=false;global.tcc_return_menu=false;
        global.tcc_notice=is_struct(_response)&&variable_struct_exists(_response,"error")?_response.error:"Resposta inválida do salvamento.";return;
    }
    switch(global.tcc_op){
    case "/settings":
        if(variable_struct_exists(_response,"data")&&is_struct(_response.data)){
            var _cfg=_response.data;
            if(variable_struct_exists(_cfg,"music")&&variable_struct_exists(_cfg,"sfx")&&variable_struct_exists(_cfg,"large")&&variable_struct_exists(_cfg,"reduced"))global.cfg={music:clamp(_cfg.music,0,0.5),sfx:clamp(_cfg.sfx,0,0.5),large:_cfg.large,reduced:_cfg.reduced};
        }
        global.tcc_notice="";break;
    case "/slots":global.tcc_slots=_response.slots;global.tcc_notice="";break;
    case "/save":
        global.tcc_dirty=false;global.tcc_notice=(tcc_web_target()?"Salvo neste dispositivo · slot ":"Salvo no banco · slot ")+string(global.tcc_slot);
        if(global.tcc_new_pending){global.tcc_new_pending=false;tcc_fechar();room_goto(rm_hub);}
        else if(global.tcc_return_menu){global.tcc_return_menu=false;tcc_fechar();room_goto(rm_menu);}break;
    case "/load":case "/recover":if(tcc_restaurar(_response.data))global.tcc_notice=(tcc_web_target()?"Partida restaurada neste dispositivo.":"Partida restaurada do banco.");break;
    }
}
function tcc_touch_pressed(_key){
    if(!tcc_web_target())return false;
    if(_key==ord("E"))return global.tcc_touch_e_pressed;
    if(_key==vk_space)return global.tcc_touch_space_pressed;
    if(_key==vk_escape)return global.tcc_touch_pause_pressed;
    return false;
}
function tcc_web_target(){return os_type==os_operagx||os_browser!=browser_not_a_browser;}
function tcc_request(_path,_body){
    if(global.tcc_busy)return false;
    global.tcc_op=_path;global.tcc_busy=true;global.tcc_wait=0;
    if(tcc_web_target()){
        try{var _response=tcc_web_request(_path,_body);tcc_process_response(_response);}
        catch(_error){global.tcc_busy=false;global.tcc_new_pending=false;global.tcc_return_menu=false;global.tcc_notice="Falha ao acessar o salvamento local do navegador.";}
        return true;
    }
    var h=ds_map_create();h[?"Content-Type"]="application/json";h[?"X-RPG-Client"]="desktop-v1";
    global.tcc_request=http_request("http://127.0.0.1:19827"+_path,"POST",h,json_stringify(_body));ds_map_destroy(h);
    return true;
}
function tcc_salvar(){
    if(global.tcc_slot<1||global.dialogo_ativo||global.intro_ativo||global.tcc_busy)return false;
    global.tcc_notice=tcc_web_target()?"Salvando neste dispositivo...":"Salvando no banco...";
    return tcc_request("/save",{slot:global.tcc_slot,data:tcc_snapshot(),new_game:false,overwrite:false});
}
function tcc_checkpoint_livre(_room,_x,_y){
    // Validation runs before entering the target room, so room_width is not its width yet.
    if(_room!=rm_hub)return jogo_posicao_livre(_room,_x,_y);
    if(_x<12||_y<12||_x>1618||_y>953)return false;
    var blocks=global.tcc_hub_blocks;
    for(var i=0;i<array_length(blocks);i++){var r=blocks[i];if(_x+7>r[0]&&_x-7<r[2]&&_y>r[1]&&_y-6<r[3])return false;}
    return true;
}
