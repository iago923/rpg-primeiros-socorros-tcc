if(tcc_modal()||!instance_exists(obj_player))exit;
if(instance_exists(obj_room_manager)&&obj_room_manager.entrada_cooldown>0)exit;
var points=[[171,267],[228,282],[414,300],[585,285],[414,174]],best=39,idx=-1;
for(var i=0;i<5;i++){var d=point_distance(obj_player.x,obj_player.y,points[i][0],points[i][1]);if(d<best){best=d;idx=i;}}
if(point_distance(obj_player.x,obj_player.y,384,309)<best)exit;
if(idx<0||(!keyboard_check_pressed(ord("E"))&&!tcc_touch_pressed(ord("E"))))exit;
var missions=[100,101,102,103,104],topics=[0,0,1,4,3],rewards=["manual","avaliacao","treino_engasgo","estabilizacao","prova"],nexts=[101,102,103,104,110];
if(global.missao==missions[idx])tcc_iniciar_caso(topics[idx],rewards[idx],nexts[idx]);
else tcc_fala("Ana · orientação","Siga a etapa atual do caderno. Você pode reler os temas pelo guia.");
