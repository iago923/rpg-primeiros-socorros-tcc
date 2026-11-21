if(tcc_modal()||!instance_exists(obj_player))exit;
if(distance_to_object(obj_player)<48&&(keyboard_check_pressed(ord("E"))||tcc_touch_pressed(ord("E")))){
 switch(global.missao){case 31:global.missao=4;break;case 61:global.missao=7;break;case 91:global.missao=10;break;}
 global.nome_missao=tcc_objetivo();global.tcc_storage=false;global.tcc_offset=0;tcc_abrir("armario");global.tcc_dirty=true;
}
