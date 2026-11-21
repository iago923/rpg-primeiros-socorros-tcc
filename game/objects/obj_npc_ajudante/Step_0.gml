depth=-y;
if(!variable_instance_exists(id,"routine_home")){routine_home=[x,y];routine_phase=0;routine_wait=120;routine_state="parado";}
if(!routine_loaded){
 routine_loaded=true;
 if(variable_struct_exists(global.mundo,npc_id)){
  var saved=variable_struct_get(global.mundo,npc_id);
  if(is_struct(saved)&&variable_struct_exists(saved,"x")&&jogo_posicao_livre(room,saved.x,saved.y)){x=saved.x;y=saved.y;}
 }
}
variable_struct_set(global.mundo,npc_id,{x:x,y:y,estado:routine_state});
if(tcc_modal()){routine_state="conversando";exit;}
if(point_distance(x,y,obj_player.x,obj_player.y)<55&&(keyboard_check_pressed(ord("E"))||tcc_touch_pressed(ord("E")))){
 tcc_concluir("conversa_"+npc_id);
 var texto=global.missao>=1&&global.missao<13?"Posso chamar um adulto e orientar o acesso ao socorro. Não precisamos buscar todo o material nem resolver isso sozinhos.":"Ana pediu que a gente conhecesse os pontos de apoio. Na sala há um livro; na enfermaria, materiais organizados.";
 if(npc_id=="bia")texto="Aqui são simulações supervisionadas. O guia ensina decisões, mas a técnica corporal precisa de treinamento prático. Podemos repetir sem pressa.";
 if(npc_id=="apoio")texto="Este armário é o ponto de reposição. Durante uma urgência, peça que alguém traga material: você não precisa abandonar a pessoa.";
 tcc_fala(npc_nome,texto);
 exit;
}
if(global.missao>=10&&global.missao<=11){routine_state="observando";exit;}
if(point_distance(x,y,obj_player.x,obj_player.y)<75){routine_state="aguardando passagem";exit;}
if(routine_wait>0){routine_wait--;routine_state="parado";exit;}
var target_x=routine_home[0]+(routine_phase==0?20:0);
var nx=x+sign(target_x-x)*0.35;
if(jogo_posicao_livre(room,nx,y)&&point_distance(nx,y,obj_player.x,obj_player.y)>45){x=nx;routine_state="andando";}
else{routine_phase=1-routine_phase;routine_wait=150;exit;}
if(abs(x-target_x)<1){routine_phase=1-routine_phase;routine_wait=irandom_range(120,240);}
