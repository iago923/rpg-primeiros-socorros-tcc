function tcc_botao(_id,_texto,_x,_y,_w,_h){return {id:_id,texto:_texto,x:_x,y:_y,w:_w,h:_h};}
function tcc_botoes(){
 var a=[],p=global.tcc_panel;
 if(room==rm_menu&&p==""){var nomes=["Novo jogo","Carregar jogo","Configurações","Créditos e fontes","Sair"],ids=["novo","carregar","config","fontes","sair"];for(var i=0;i<5;i++)array_push(a,tcc_botao(ids[i],nomes[i],90,300+i*65,360,52));return a;}
 if(p=="slots_novo"||p=="slots_load"){
  for(var i=0;i<3;i++){var label="Slot "+string(i+1)+" · indisponível";if(array_length(global.tcc_slots)>i){var s=global.tcc_slots[i];label="Slot "+string(i+1)+" · "+(s.state=="empty"?"Vazio":(s.state=="invalid"?"Inválido · recuperar cópia":s.data.objective+" · "+string(floor(s.data.seconds/60))+" min · "+s.updated));}array_push(a,tcc_botao("slot"+string(i+1),label,112,210+i*98,1056,74));}
  array_push(a,tcc_botao("refresh","Atualizar",112,538,220,48));
 } else if(p=="tarefas"){
  array_push(a,tcc_botao("tarefas_opcionais","Atividades opcionais",112,564,430,48));
 } else if(p=="tarefas_opcionais"){
  var quests=tcc_missoes();
  for(var i=11;i<array_length(quests);i++)array_push(a,tcc_botao("quest"+string(i),quests[i].objetivo,112,210+(i-11)*74,475,60));
  array_push(a,tcc_botao("tarefas","Ver campanha",112,554,330,48));
 } else if(p=="confirmar"){
  array_push(a,tcc_botao("overwrite","Confirmar novo jogo neste slot",112,360,660,60));
 } else if(p=="confirmar_menu"){
  array_push(a,tcc_botao("save_menu","Salvar e voltar ao menu",112,340,700,60));
  array_push(a,tcc_botao("discard_menu","Voltar sem salvar agora",112,424,700,60));
 } else if(p=="config"){
  for(var i=0;i<2;i++){array_push(a,tcc_botao("volume"+string(i)+"menos","-",612,190+i*70,60,52));array_push(a,tcc_botao("volume"+string(i)+"mais","+",690,190+i*70,60,52));}
  var labels=[(global.cfg.large?"[x]":"[ ]")+" Texto grande",(global.cfg.reduced?"[x]":"[ ]")+" Efeitos reduzidos",(window_get_fullscreen()?"[x]":"[ ]")+" Tela cheia"];
  for(var i=0;i<3;i++)array_push(a,tcc_botao("cfg"+string(i+2),labels[i],112,330+i*70,650,52));
 } else if(p=="bolsa"||p=="armario"){
  var list=global.tcc_storage?global.armario:global.bolsa;
  for(var i=0;i<min(8,ds_list_size(list)-global.tcc_offset);i++){var k=i+global.tcc_offset,e=list[|k],item=tcc_item(e.item_id);array_push(a,tcc_botao("item"+string(k),item.nome+"  ×"+string(e.quantity),112,176+i*46,470,40));}
  if(!global.tcc_storage)array_push(a,tcc_botao("kit","Abrir kit",650,390,240,48));
  array_push(a,tcc_botao("ordem","Mover para o início",650,448,350,48));
  if(p=="armario"){
   array_push(a,tcc_botao("transfer","Transferir selecionado",650,506,390,48));
   array_push(a,tcc_botao("storage",global.tcc_storage?"Ver bolsa":"Ver armário",650,564,240,48));
   array_push(a,tcc_botao("repor","Reposição orientada",900,564,268,48));
   array_push(a,tcc_botao("previtems","<",112,558,80,44));array_push(a,tcc_botao("nextitems",">",202,558,80,44));
  }
 } else if(p=="guia_index"){
  var topics=tcc_topicos();for(var i=0;i<array_length(topics);i++){
   var estado="não lido";
   if(variable_struct_exists(global.aprendizagem,topics[i].id)){var l=variable_struct_get(global.aprendizagem,topics[i].id);estado=l.praticado?"compreensão revisada":(l.lido?"lido":"não lido");}
   array_push(a,tcc_botao("topic"+string(i),topics[i].titulo+" · "+estado,112,180+i*65,900,52));
  }
 } else if(p=="guia"||p=="preparo"){
  array_push(a,tcc_botao("pageprev","< Voltar",112,548,190,50));array_push(a,tcc_botao("pagenext","Avançar >",320,548,210,50));
  if(global.tcc_page==array_length(tcc_topicos()[global.tcc_topic].paginas)-1)array_push(a,tcc_botao(is_struct(global.tcc_case)?"praticar":"compreensao",is_struct(global.tcc_case)?"Continuar decisões":"Verificar compreensão",660,548,450,50));
 } else if(p=="cena"||p=="orientacao"){
  array_push(a,tcc_botao(p=="cena"?"observar":"entendi",p=="cena"?"Observar com atenção":"Agora vou tentar",112,540,460,52));
  array_push(a,tcc_botao("readcase","Consultar guia",690,540,450,52));
 } else if(p=="material"){
  var c=global.tcc_case;
  if(c.training){array_push(a,tcc_botao("usar_cobertura","Cobertura de treino ×"+string(c.stock),112,275,510,54));array_push(a,tcc_botao("usar_gaze","Examinar gaze de demonstração",112,341,510,54));}
  else {var cat=tcc_catalogo();var row=0;for(var i=0;i<array_length(cat);i++){var count=tcc_quantidade(global.bolsa,cat[i].id);if(count>0){array_push(a,tcc_botao("usar_"+cat[i].id,cat[i].nome+" ×"+string(count),112,250+row*48,550,42));row++;}}}
  array_push(a,tcc_botao("apoio_material","Pedir material ao apoio",700,490,440,50));
  array_push(a,tcc_botao("cancelar_material","Voltar sem usar",700,552,440,50));
 } else if(p=="confirmar_material"){
  array_push(a,tcc_botao("aplicar_material","Confirmar aplicação",112,540,480,52));
  array_push(a,tcc_botao("cancelar_material","Cancelar sem gastar",670,540,480,52));
 } else if(p=="caso"){
  var c=global.tcc_case,qs=tcc_questoes(tcc_topicos()[c.topic].id),q=qs[c.step];
  if(c.feedback==""){
   if(tcc_material_etapa()){array_push(a,tcc_botao("abrir_material","Abrir bolsa",112,350,1056,58));array_push(a,tcc_botao("apoio_material","Pedir cobertura ao apoio",112,424,1056,58));}
   else for(var i=0;i<array_length(q.opcoes);i++)array_push(a,tcc_botao("answer"+string(i),q.opcoes[i],112,330+i*76,1056,64));
  }
  else array_push(a,tcc_botao("nextcase",c.correct?"Continuar":"Rever a decisão",112,530,440,54));
  array_push(a,tcc_botao("readcase","Consultar guia",858,176,310,48));
  array_push(a,tcc_botao("dica","Me dê uma dica",490,176,340,48));
  array_push(a,tcc_botao("save","Salvar etapa",858,580,310,44));
 } else if(p=="pausa"){
  var ids=["bolsa","guia_index","tarefas","save","config","menu"],names=["Bolsa de materiais","Guia de aprendizagem","Tarefas e progresso","Salvar partida","Configurações","Voltar ao menu"];
  for(var i=0;i<6;i++)array_push(a,tcc_botao(ids[i],names[i],112,166+i*66,620,52));
 } else if(p=="fontes"){
  array_push(a,tcc_botao("fontes_detalhes","Consultar fontes",112,560,450,48));
 } else if(p=="fontes_detalhes"){
  var ids=["link_samu","link_aha","link_aid","link_bvs","link_al","link_estatistica"];
  var nomes=["SAMU 192","AHA: adultos 2025","Primeiros socorros 2024","BVS: queimaduras","SES-AL: queimaduras","Saúde Brasil 2023"];
  for(var i=0;i<6;i++)array_push(a,tcc_botao(ids[i],nomes[i],112+(i mod 3)*350,490+(i div 3)*58,330,48));
 } else if(p=="final")array_push(a,tcc_botao("fontes","Fontes e próximos estudos",112,560,650,48));
 if(p!=""&&p!="caso"&&p!="preparo"&&p!="cena"&&p!="orientacao"&&p!="material"&&p!="confirmar_material")array_push(a,tcc_botao("close","Voltar",1028,98,140,44));
 return a;
}
function tcc_novo_slot(_slot,_overwrite){
 global.tcc_slot=_slot;tcc_reset();global.tcc_panel="slots_novo";
 global.tcc_new_pending=true;tcc_request("/save",{slot:_slot,data:tcc_snapshot(),new_game:true,overwrite:_overwrite});
}
function tcc_acao(_id){
 if(_id=="observar"){tcc_abrir("orientacao");return;}
 if(_id=="entendi"){global.tcc_case.taught=true;tcc_abrir("caso");return;}
 if(_id=="dica"){tcc_abrir("orientacao");return;}
 if(_id=="abrir_material"){if(tcc_material_etapa())tcc_abrir("material");return;}
 if(string_copy(_id,1,5)=="usar_"){tcc_escolher_material(string_delete(_id,1,5));return;}
 if(_id=="apoio_material"){if(tcc_material_etapa()){global.tcc_case.selected="cobertura";global.tcc_case.source="apoio";tcc_abrir("confirmar_material");}return;}
 if(_id=="aplicar_material"){if(!tcc_aplicar_material())global.tcc_notice="Ação não aplicada. Confira a etapa e o estoque.";return;}
 if(_id=="cancelar_material"){global.tcc_case.selected="";global.tcc_case.source="";tcc_abrir("caso");return;}
 if(_id=="close"&&global.tcc_panel=="fontes_detalhes"){tcc_abrir("fontes");return;}
 if(string_copy(_id,1,5)=="quest"){global.tcc_quest_selected=clamp(real(string_delete(_id,1,5)),11,array_length(tcc_missoes())-1);return;}
 if(_id=="close"){if(is_struct(global.tcc_case)){tcc_abrir("caso");}else tcc_fechar();return;}
 if(_id=="novo"||_id=="carregar"){tcc_abrir(_id=="novo"?"slots_novo":"slots_load");global.tcc_notice="Consultando partidas...";tcc_request("/slots",{});return;}
 if(_id=="refresh"){tcc_request("/slots",{});return;}
 if(string_copy(_id,1,4)=="slot"){
  var n=real(string_delete(_id,1,4));if(array_length(global.tcc_slots)<n){global.tcc_notice="Inicie o serviço de salvamento e tente atualizar.";return;}
  var s=global.tcc_slots[n-1];global.tcc_slot=n;
  if(global.tcc_panel=="slots_novo"){if(s.state=="empty")tcc_novo_slot(n,false);else tcc_abrir("confirmar");}
  else {if(s.state=="empty"){global.tcc_notice="Este slot está vazio.";return;}tcc_request(s.state=="invalid"?"/recover":"/load",{slot:n});}
  return;
 }
 if(_id=="overwrite"){tcc_novo_slot(global.tcc_slot,true);return;}
 if(_id=="save"){if(!tcc_salvar())global.tcc_notice="Salve fora de diálogos e atendimentos.";return;}
 if(_id=="sair"){game_end();return;}
 if(_id=="link_samu"){url_open("https://www.gov.br/saude/pt-br/composicao/saes/samu-192");return;}
 if(_id=="link_aha"){url_open("https://cpr.heart.org/en/resuscitation-science/cpr-and-ecc-guidelines/adult-basic-life-support");return;}
 if(_id=="link_aid"){url_open("https://cpr.heart.org/en/resuscitation-science/2024-first-aid-guidelines");return;}
 if(_id=="link_bvs"){url_open("https://bvsms.saude.gov.br/bvs/dicas/54queimaduras.html");return;}
 if(_id=="link_al"){url_open("https://cidadao.saude.al.gov.br/saude-para-voce/primeiros-socorros/queimadura/");return;}
 if(_id=="link_estatistica"){url_open("https://www.gov.br/saude/pt-br/centrais-de-conteudo/publicacoes/svsa/analise-de-situacao-de-saude/saude-brasil-2023-analise-da-situacao-de-saude-com-enfoque-nas-criancas-brasileiras-versao-preliminar/@@download/file/preliminar%20SAU%CC%81DE%20BRASIL%202023_7nov23.pdf");return;}
 if(_id=="menu"){tcc_abrir("confirmar_menu");return;}
 if(_id=="save_menu"){global.tcc_return_menu=true;if(!tcc_salvar()){global.tcc_return_menu=false;global.tcc_notice="Não foi possível salvar agora. Sua partida continua aberta.";}return;}
 if(_id=="discard_menu"){global.tcc_return_menu=false;tcc_fechar();room_goto(rm_menu);return;}
 if(string_copy(_id,1,3)=="cfg"){
  var n=real(string_delete(_id,1,3));switch(n){case 0:global.cfg.music=global.cfg.music>=0.5?0:global.cfg.music+0.1;break;case 1:global.cfg.sfx=global.cfg.sfx>=0.5?0:global.cfg.sfx+0.1;break;case 2:global.cfg.large=!global.cfg.large;break;case 3:global.cfg.reduced=!global.cfg.reduced;break;case 4:window_set_fullscreen(!window_get_fullscreen());break;}
  tcc_request("/settings",{data:global.cfg});return;
 }
 if(string_copy(_id,1,6)=="volume"){
  var change=string_pos("menos",_id)>0?-0.1:0.1;
  if(string_char_at(_id,7)=="0")global.cfg.music=clamp(global.cfg.music+change,0,0.5);
  else global.cfg.sfx=clamp(global.cfg.sfx+change,0,0.5);
  tcc_request("/settings",{data:global.cfg});return;
 }
 if(string_copy(_id,1,4)=="item"){global.tcc_selected=real(string_delete(_id,1,4));return;}
 if(_id=="kit"){global.tcc_notice=tcc_abrir_kit()?"Pacote aberto: conteúdo conferido.":"Sem kit ou sem espaço para todo o conteúdo. Nada foi alterado.";return;}
 if(_id=="ordem"){tcc_reorganizar_lista(global.tcc_storage?global.armario:global.bolsa,global.tcc_selected,0);global.tcc_selected=0;global.tcc_offset=0;return;}
 if(_id=="storage"){global.tcc_storage=!global.tcc_storage;global.tcc_selected=0;global.tcc_offset=0;global.tcc_focus=0;return;}
 if(_id=="previtems"||_id=="nextitems"){var count=ds_list_size(global.tcc_storage?global.armario:global.bolsa);global.tcc_offset=clamp(global.tcc_offset+(_id=="nextitems"?8:-8),0,max(0,count-8));return;}
 if(_id=="transfer"){global.tcc_notice=tcc_transferir(global.tcc_storage?global.armario:global.bolsa,global.tcc_storage?global.bolsa:global.armario,global.tcc_selected,global.tcc_storage?8:24)?"Material transferido.":"Sem espaço ou sem seleção válida.";return;}
 if(_id=="repor"){
  var falta=max(0,3-tcc_quantidade(global.bolsa,"cobertura"));
  if(falta==0){global.tcc_notice="Você já tem pelo menos três coberturas. A bolsa continua com você.";tcc_concluir("organizar");return;}
  if(tcc_adicionar(global.bolsa,"cobertura",falta,8)){global.tcc_notice="Materiais repostos: três coberturas na bolsa.";global.tcc_dirty=true;tcc_concluir("organizar");}
  else global.tcc_notice="Guarde materiais antigos no armário para liberar espaço. Durante uma ocorrência, peça apoio.";return;
 }
 if(string_copy(_id,1,5)=="topic"){tcc_estudar(real(string_delete(_id,1,5)));return;}
 if(_id=="pageprev"||_id=="pagenext"){
  var topic=tcc_topicos()[global.tcc_topic];global.tcc_page=clamp(global.tcc_page+(_id=="pagenext"?1:-1),0,array_length(topic.paginas)-1);
  if(global.tcc_page==array_length(topic.paginas)-1){var before=variable_struct_exists(global.aprendizagem,topic.id)?variable_struct_get(global.aprendizagem,topic.id):{praticado:false};variable_struct_set(global.aprendizagem,topic.id,{lido:true,praticado:before.praticado});global.tcc_dirty=true;}return;
 }
 if(_id=="praticar"){tcc_abrir("caso");return;}
 if(_id=="compreensao"){tcc_iniciar_caso(global.tcc_topic,"revisao_"+tcc_topicos()[global.tcc_topic].id,-1);tcc_abrir("caso");return;}
 if(_id=="readcase"){global.tcc_topic=global.tcc_case.topic;tcc_abrir("guia");return;}
 if(_id=="nextcase"){tcc_caso_avancar();return;}
 if(string_copy(_id,1,6)=="answer"){tcc_responder(real(string_delete(_id,1,6)));return;}
 tcc_abrir(_id);
}
function tcc_ui_step(){
 if(global.tcc_input_lock>0){global.tcc_input_lock--;return;}
 if(global.tcc_busy)return;
 if(global.dialogo_ativo||global.intro_ativo)return;
 if(keyboard_check_pressed(vk_escape)||tcc_touch_pressed(vk_escape)){
  if(global.tcc_panel=="material"||global.tcc_panel=="confirmar_material"){tcc_acao("cancelar_material");return;}
  if(global.tcc_panel=="caso"||global.tcc_panel=="preparo"||global.tcc_panel=="cena"||global.tcc_panel=="orientacao")return;
  if(global.tcc_panel!="")tcc_acao("close");else if(room!=rm_menu)tcc_abrir("pausa");return;
 }
 if(room!=rm_menu&&global.tcc_panel==""){
  if(keyboard_check_pressed(ord("I"))){global.tcc_storage=false;tcc_abrir("bolsa");}
  if(keyboard_check_pressed(ord("G")))tcc_abrir("guia_index");
  if(keyboard_check_pressed(ord("J")))tcc_abrir("tarefas");
 }
 var buttons=tcc_botoes(),n=array_length(buttons);if(n==0)return;
 global.tcc_focus=clamp(global.tcc_focus,0,n-1);
 if(keyboard_check_pressed(vk_down)||keyboard_check_pressed(vk_tab))global.tcc_focus=(global.tcc_focus+1) mod n;
 if(keyboard_check_pressed(vk_up))global.tcc_focus=(global.tcc_focus+n-1) mod n;
 var mx=device_mouse_x_to_gui(0),my=device_mouse_y_to_gui(0);
 for(var i=0;i<n;i++)if(point_in_rectangle(mx,my,buttons[i].x,buttons[i].y,buttons[i].x+buttons[i].w,buttons[i].y+buttons[i].h)){
  if(mx!=global.tcc_mouse_x||my!=global.tcc_mouse_y)global.tcc_focus=i;
  if(mouse_check_button_pressed(mb_left)||device_mouse_check_button_pressed(0,mb_left)){tcc_acao(buttons[i].id);global.tcc_input_lock=2;return;}
 }
 global.tcc_mouse_x=mx;global.tcc_mouse_y=my;
 if(keyboard_check_pressed(vk_enter)){tcc_acao(buttons[global.tcc_focus].id);global.tcc_input_lock=2;}
}
function tcc_web_text(_value){
 var _s=string(_value);
 if(!tcc_web_target())return _s;
 var _from=["á","à","â","ã","ä","é","è","ê","ë","í","ì","î","ï","ó","ò","ô","õ","ö","ú","ù","û","ü","ç","ñ","Á","À","Â","Ã","Ä","É","È","Ê","Ë","Í","Ì","Î","Ï","Ó","Ò","Ô","Õ","Ö","Ú","Ù","Û","Ü","Ç","Ñ","·","—","–","↑","↓","←","→","“","”","‘","’"];
 var _to=["a","a","a","a","a","e","e","e","e","i","i","i","i","o","o","o","o","o","u","u","u","u","c","n","A","A","A","A","A","E","E","E","E","I","I","I","I","O","O","O","O","O","U","U","U","U","C","N","-","-","-","^","v","<",">","\"","\"","'","'"];
 for(var i=0;i<array_length(_from);i++)_s=string_replace_all(_s,_from[i],_to[i]);
 return _s;
}
function tcc_draw_text(_x,_y,_text){draw_text(_x,_y,tcc_web_text(_text));}
function tcc_draw_text_ext(_x,_y,_text,_sep,_width){draw_text_ext(_x,_y,tcc_web_text(_text),_sep,_width);}
function tcc_draw_text_transformed(_x,_y,_text,_xs,_ys,_angle){draw_text_transformed(_x,_y,tcc_web_text(_text),_xs,_ys,_angle);}
function tcc_text(_x,_y,_text,_width){tcc_draw_text_ext(_x,_y,_text,global.cfg.large?31:27,_width);}
function tcc_frame(_x,_y,_w,_h){
 draw_set_color(make_color_rgb(20,35,33));draw_rectangle(_x+5,_y+6,_x+_w+5,_y+_h+6,false);
 draw_set_color(make_color_rgb(235,240,224));draw_rectangle(_x,_y,_x+_w,_y+_h,false);
 draw_set_color(make_color_rgb(55,110,98));draw_rectangle(_x,_y,_x+_w,_y+_h,true);
}
function tcc_ui_draw(){
 draw_set_alpha(1);draw_set_halign(fa_left);draw_set_valign(fa_top);draw_set_font(global.cfg.large?global.font_large:global.font_body);
 var p=global.tcc_panel;
 if(room==rm_menu&&p==""){
  draw_set_color(make_color_rgb(12,32,29));draw_set_alpha(0.82);draw_rectangle(40,30,520,690,false);draw_set_alpha(1);
  draw_set_font(global.font_title);draw_set_color(make_color_rgb(246,239,197));tcc_draw_text(90,100,"RPG Primeiros\nSocorros");
  draw_set_font(global.font_body);draw_set_color(c_white);tcc_text(90,217,"Uma escola. Pessoas que cuidam.\nUm passo de cada vez.",380);
 } else if(p==""&&room!=rm_menu){
  tcc_frame(22,20,500,104);draw_set_color(make_color_rgb(29,65,56));tcc_draw_text(40,31,"OBJETIVO · "+string(tcc_percentual())+"%");
  tcc_text(40,60,global.nome_missao,458);draw_set_color(make_color_rgb(70,145,120));draw_rectangle(40,113,40+460*tcc_percentual()/100,118,false);
  draw_set_color(c_white);if(!tcc_web_target())tcc_draw_text(24,680,"I · Bolsa     G · Guia     J · Tarefas     Esc · Pausa");
 }
 if(p!=""){
  draw_set_alpha(0.52);draw_set_color(c_black);draw_rectangle(0,0,1280,720,false);draw_set_alpha(1);tcc_frame(80,70,1120,580);
  draw_set_color(make_color_rgb(24,71,60));draw_set_font(global.font_title);
  var title=p;switch(p){case "bolsa":title="Bolsa de materiais";break;case "armario":title="Armário da enfermaria";break;case "guia_index":case "guia":title="Caderno de aprendizagem";break;case "preparo":title="Leia, observe e prepare";break;case "caso":title="Decisões de atendimento";break;case "slots_novo":title="Escolha uma partida";break;case "slots_load":title="Continuar sua história";break;case "config":title="Configurações";break;case "pausa":title="Uma pausa";break;case "tarefas":title="Caminho percorrido";break;case "fontes":title="Créditos e fontes";break;case "final":title="Cuidar também é continuar aprendendo";break;case "confirmar":title="Confirmar substituição";break;}
  if(p=="confirmar_menu")title="Antes de sair";
  if(p=="tarefas_opcionais")title="Pequenos cuidados, grandes vínculos";
  if(p=="fontes_detalhes")title="Fontes do conteúdo educativo";
  if(p=="cena")title=global.tcc_case.training?"Oficina com Ana":"O que aconteceu?";
  if(p=="orientacao")title="Ana explica o próximo cuidado";
  if(p=="material")title=global.tcc_case.training?"Materiais exclusivos do treino":"Sua bolsa de materiais";
  if(p=="confirmar_material")title="Conferir antes de aplicar";
  tcc_draw_text(112,102,title);draw_set_font(global.cfg.large?global.font_large:global.font_body);
  if(p=="config"){tcc_draw_text(112,205,"Música · "+string(round(global.cfg.music*100))+"%");tcc_draw_text(112,275,"Efeitos · "+string(round(global.cfg.sfx*100))+"%");}
  if(p=="bolsa"||p=="armario"){
   var list=global.tcc_storage?global.armario:global.bolsa;tcc_draw_text(650,180,(global.tcc_storage?"Armário ":"Bolsa ")+string(ds_list_size(list))+" / "+string(global.tcc_storage?24:8)+" slots");
   if(global.tcc_selected<ds_list_size(list)){var e=list[|global.tcc_selected],item=tcc_item(e.item_id);draw_sprite_ext(item.icone,0,665,245,1,1,0,c_white,1);tcc_text(710,240,item.desc,440);}
   else tcc_text(650,240,"Selecione um material. O guia nunca ocupa espaço na bolsa.",430);
  }
  if(p=="guia"||p=="preparo"){
   var t=tcc_topicos()[global.tcc_topic];tcc_draw_text(112,180,t.titulo+" · "+string(global.tcc_page+1)+"/"+string(array_length(t.paginas)));
   tcc_text(112,244,t.paginas[global.tcc_page],1030);draw_set_color(make_color_rgb(77,94,80));tcc_text(112,432,t.fonte,1040);
   if(is_struct(global.tcc_case))tcc_draw_text(112,494,"Simulação pausada para leitura");
  }
  if(p=="caso"){
   var c=global.tcc_case,qs=tcc_questoes(tcc_topicos()[c.topic].id),q=qs[c.step];tcc_draw_text(112,180,"Etapa "+string(c.step+1)+" de "+string(array_length(qs)));
   tcc_text(112,248,q.texto,1030);if(c.feedback!="")tcc_text(112,355,c.feedback,c.consumed?740:1030);
   if(c.consumed){
    draw_sprite_ext(spr_aluno_queimado,0,1015,494,1.35,1.35,0,c.training?make_color_rgb(155,180,180):c_white,1);
    draw_set_color(c_white);draw_rectangle(1020,431,1029,440,false);
    draw_set_color(make_color_rgb(55,110,98));draw_rectangle(1020,431,1029,440,true);
    tcc_draw_text(914,310,c.training?"Modelo de treino":"Cobertura aplicada");
    tcc_draw_text(935,505,"Estoque: "+string(c.training?c.stock:tcc_quantidade(global.bolsa,"cobertura")));
   }
  }
  if(p=="cena"||p=="orientacao"){
   var c=global.tcc_case;
   tcc_text(112,205,p=="cena"?tcc_cena(c):tcc_orientacao(c.topic,c.step),c.topic==3?740:1020);
   if(c.topic==3){
    draw_sprite_ext(spr_aluno_queimado,0,1020,420,1.6,1.6,0,c.training?make_color_rgb(155,180,180):c_white,1);
    if(p=="orientacao"&&c.step==2){draw_set_color(c_white);draw_rectangle(1026,345,1037,356,false);draw_set_color(make_color_rgb(55,110,98));draw_rectangle(1026,345,1037,356,true);}
    draw_set_color(make_color_rgb(24,71,60));tcc_draw_text(930,200,c.training?"Modelo de treino":"Colega de 18 anos");
   }
   tcc_text(112,437,"Simulação pausada para leitura. Essa pausa é do jogo; numa emergência real, peça ajuda sem esperar.",1020);
  }
  if(p=="material"){
   tcc_draw_text(112,190,global.tcc_case.training?"Estoque do modelo de treino; sua bolsa não será alterada.":"Selecione um material para examinar. Nada é gasto ao selecionar.");
   tcc_text(710,285,"A pele já foi resfriada sob orientação. Qual material protege sem grudar nem apertar?",425);
  }
  if(p=="confirmar_material"){
   var c=global.tcc_case;
   tcc_text(112,205,"Aplicar cobertura limpa não aderente na pequena área já resfriada, com pele intacta, sem apertar. O funcionário continua acompanhando enquanto aguarda avaliação.",1020);
   tcc_text(112,345,c.source=="apoio"?"O apoio traz a cobertura. Você permanece ao lado do colega; nenhum item da sua bolsa será gasto.":"Confirmar usa exatamente uma cobertura"+(c.training?" do estoque de treino. Sua bolsa não muda.":" da sua bolsa. Cancelar não gasta nada."),1020);
  }
  if(p=="confirmar")tcc_text(112,220,"O progresso do slot "+string(global.tcc_slot)+" será substituído. A versão anterior fica como cópia recuperável. Outros slots não serão alterados.",1000);
  if(p=="confirmar_menu")tcc_text(112,220,"Deseja registrar seu progresso antes de voltar ao menu? Uma falha no salvamento mantém esta partida aberta.",1000);
  if(p=="tarefas"){
   tcc_draw_text(112,180,"Campanha: "+string(tcc_percentual())+"% · XP "+string(global.xp));
   var quests=tcc_missoes(),optional_done=0;
   for(var i=0;i<11;i++){
    var col=i div 6,row=i mod 6,state=tcc_missao_estado(quests[i]);
    draw_set_color(state=="bloqueada"?make_color_rgb(95,105,96):make_color_rgb(24,71,60));
    var label=(state=="concluida"?"[ok] ":"[  ] ")+quests[i].objetivo;
    var scale=min(1,465/max(1,string_width(label)));
    tcc_draw_text_transformed(112+col*520,232+row*42,label,scale,scale,0);
   }
   for(var i=11;i<array_length(quests);i++)if(tcc_missao_estado(quests[i])=="concluida")optional_done++;
   draw_set_color(make_color_rgb(24,71,60));
   tcc_draw_text(112,506,"Atividades opcionais: "+string(optional_done)+"/4 · não alteram os 100% da campanha.");
  }
  if(p=="tarefas_opcionais"){
   var quest=tcc_missoes()[global.tcc_quest_selected],state=tcc_missao_estado(quest);
   var locais=["Corredor central","Sala de aula","Enfermaria","Centro de treinamento"];
   var dicas=["Converse com Rafa sobre os pontos de apoio da escola.","Interaja com o livro da sala. O conteúdo fica no caderno, sem ocupar a bolsa.","Confira o armário. Quando não houver um kit disponível na bolsa ou no armário, peça reposição orientada.","Depois de conhecer Ana, converse com Bia sobre o que a simulação ensina e seus limites."];
   var index=global.tcc_quest_selected-11;
   tcc_draw_text(622,190,state=="concluida"?"CONCLUÍDA":(state=="bloqueada"?"AINDA NÃO DISPONÍVEL":"DISPONÍVEL"));
   tcc_text(622,244,"Quem: "+quest.responsavel+"\nOnde: "+locais[index],510);
   tcc_text(622,340,dicas[index],510);
   tcc_text(622,510,state=="concluida"?"Você já recebeu os 10 XP desta tarefa.":"Recompensa: 10 XP, uma única vez.",510);
  }
  if(p=="fontes")tcc_text(112,184,"RPG Primeiros Socorros\nProjeto: Iago\nDocumentação: Guilherme Dominguez Rodrigues, Breno Silva de Carvalho e Gabriel Oliveira Rosa.\n\nConteúdo educativo: Ministério da Saúde / SAMU 192, AHA e Cruz Vermelha.\nFonte da interface: Nunito Sans, autores do projeto; licença SIL OFL 1.1.\nJogo educativo: não substitui treinamento prático. Revisão profissional ainda pendente.",1030);
  if(p=="fontes_detalhes")tcc_text(112,180,"Ministério da Saúde: SAMU 192; BVS, Queimaduras (2004).\nAHA: suporte básico de vida em adultos (2025).\nAHA / Cruz Vermelha: primeiros socorros (2024).\nSecretaria de Saúde de Alagoas: Queimadura.\nEstatística: Saúde Brasil 2023, versão preliminar, capítulo 13, tabela 1, p. 303. SIM: 112 óbitos por quedas, Brasil, crianças de 0 a 9 anos, 2021. O dado não mede falta de conhecimento.\nConsulta registrada em 20/09/2026. Links das publicações abaixo.",1030);
  if(p=="final")tcc_text(112,180,"Ana: Obrigada por ouvir, preparar e pedir ajuda. Rafa: Nossa parte continua na prevenção.\nNo Brasil, foram registrados 112 óbitos por quedas em crianças de 0 a 9 anos em 2021 (SIM; Saúde Brasil 2023, tabela 1). O dado não mede falta de conhecimento e não se refere aos adultos dos casos do jogo.\nPor trás de cada número existe uma pessoa e uma história. Continue aprendendo e compartilhe conhecimento confiável. Em emergências, SAMU 192.\nTemas estudados podem ser revisitados no guia. Isso não é certificação médica.",1030);
 }
 var b=tcc_botoes();for(var i=0;i<array_length(b);i++){
  var q=b[i],selected=i==global.tcc_focus;draw_set_color(selected?make_color_rgb(48,117,97):make_color_rgb(215,225,204));draw_rectangle(q.x,q.y,q.x+q.w,q.y+q.h,false);
  draw_set_color(selected?c_white:make_color_rgb(25,60,51));var scale=min(1,(q.w-24)/max(1,string_width(q.texto)));tcc_draw_text_transformed(q.x+12,q.y+10,q.texto,scale,scale,0);
 }
 if(global.tcc_notice!=""&&!global.intro_ativo&&!global.dialogo_ativo){draw_set_color(make_color_rgb(18,37,32));draw_rectangle(20,628,1260,670,false);draw_set_color(c_white);draw_set_font(global.font_body);tcc_text(35,635,global.tcc_notice,1220);}
 if(global.tcc_busy){draw_set_color(c_white);tcc_draw_text(1010,682,"Aguarde...");}
 if(tcc_web_target()&&room!=rm_menu&&p==""){
  draw_set_alpha(0.62);draw_set_color(make_color_rgb(20,42,36));draw_circle(1220,72,25,false);
  if(!global.dialogo_ativo&&!global.intro_ativo){draw_circle(75,555,30,false);draw_circle(135,615,30,false);draw_circle(195,615,30,false);draw_circle(135,675,30,false);}
  draw_circle(1170,585,44,false);draw_circle(1060,642,46,false);draw_set_alpha(1);
  draw_set_font(global.font_body);draw_set_halign(fa_center);draw_set_valign(fa_middle);draw_set_color(c_white);
  if(!global.dialogo_ativo&&!global.intro_ativo){tcc_draw_text(75,555,"↑");tcc_draw_text(135,615,"←");tcc_draw_text(195,615,"→");tcc_draw_text(135,675,"↓");}
  tcc_draw_text(1220,72,"II");tcc_draw_text(1170,585,"E");tcc_draw_text(1060,642,"OK");draw_set_halign(fa_left);draw_set_valign(fa_top);
 }
 draw_set_font(-1);draw_set_color(c_white);
}
