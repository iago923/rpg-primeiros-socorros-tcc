if(tcc_modal()||!instance_exists(obj_player))exit;
if(distance_to_object(obj_player)<48&&(keyboard_check_pressed(ord("E"))||tcc_touch_pressed(ord("E")))){tcc_concluir("leitura_sala");tcc_estudar(0);}
