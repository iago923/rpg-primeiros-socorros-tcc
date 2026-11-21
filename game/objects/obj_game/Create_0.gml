if (instance_number(obj_game) > 1) { instance_destroy(); exit; }
global.introducao_vista = false;
audio_stop_all();
global.xp = 0;
global.missao = 0;
global.nome_missao = "Fale com a professora Ana na secretaria";
global.local_atual = "CORREDOR CENTRAL";

global.dialogo_ativo = false;
global.dialogo_titulo = "";
global.dialogo_texto = "";
global.dialogo_pode_fechar = 0;

global.minigame_engasgo = false;
global.progresso_engasgo = 0;
global.tempo_engasgo = 0;
global.minigame_desmaio = false;

global.jogo_finalizado = false;
global.intro_ativo = false;
global.sentado = false;
global.itens_coletados = 0;
global.lore = 0;

global.conhecimento = 0;
global.avaliacao = 0;
global.tecnica_engasgo = 0;
global.estabilizacao = 0;
global.capacitado = false;

global.voltando_treinamento = false;

global.spawn_pendente=false; global.spawn_x=1015; global.spawn_y=430;

global.bolsa=ds_list_create();global.armario=ds_list_create();owns_tcc=true;
global.progresso={};global.aprendizagem={};global.mundo={};global.segundos=0;
global.tcc_slot=0;global.tcc_slots=[];global.tcc_panel="";global.tcc_case=undefined;
global.tcc_focus=0;global.tcc_page=0;global.tcc_topic=0;global.tcc_selected=0;global.tcc_offset=0;global.tcc_storage=false;
global.tcc_input_lock=2;global.tcc_mouse_x=-1;global.tcc_mouse_y=-1;
global.tcc_busy=false;global.tcc_request=-1;global.tcc_wait=0;global.tcc_op="";global.tcc_new_pending=false;
global.tcc_notice="";global.tcc_dirty=false;global.tcc_facing="baixo";global.tcc_feedback="";
global.tcc_save_cooldown=0;
global.tcc_return_menu=false;
global.tcc_quest_selected=11;
global.tcc_notice_last="";global.tcc_notice_time=0;
global.tcc_hub_blocks=[[0,0,615,418],[615,0,934,284],[1135,0,1630,296],[1078,296,1630,638],[589,380,936,690],[0,535,484,965],[538,736,1023,965],[1118,650,1630,965],[420,396,481,441],[24,488,67,535],[938,183,975,242],[1080,205,1117,256],[1041,436,1077,478],[854,666,908,719],[489,821,527,885],[1029,830,1068,887]];
global.cfg={music:0.2,sfx:0.25,large:false,reduced:true};
global.tcc_touch_h=0;global.tcc_touch_v=0;
global.tcc_touch_e_down=false;global.tcc_touch_e_pressed=false;
global.tcc_touch_space_down=false;global.tcc_touch_space_pressed=false;
global.tcc_touch_pause_pressed=false;
if(tcc_web_target()){
    global.font_body=-1;global.font_large=-1;global.font_title=-1;
}else{
    global.font_body=font_add("fontes/NunitoSansMedium.ttf",18,false,false,32,255);
    global.font_large=font_add("fontes/NunitoSansMedium.ttf",21,false,false,32,255);
    global.font_title=font_add("fontes/NunitoSansMedium.ttf",27,true,false,32,255);
}
depth=-10000;
display_set_gui_size(1280,720);if(!tcc_web_target())http_set_connect_timeout(4);
tcc_request("/settings",{});
