prompt_porta=false; prompt_nome="";

display_set_gui_size(1280,720);

entrada_cooldown=12;

tcc_camera();
if(room==rm_treinamento||room==rm_enfermaria){
 var px=room==rm_treinamento?325:290,py=room==rm_treinamento?178:248;
 if(jogo_posicao_livre(room,px,py)){
  var npc=instance_create_depth(px,py,-py,obj_npc_ajudante);
  npc.image_xscale=0.6;npc.image_yscale=0.6;
  npc.npc_id=room==rm_treinamento?"bia":"apoio";
  npc.npc_nome=room==rm_treinamento?"Bia · monitora":"Funcionário de apoio";
 }
}
