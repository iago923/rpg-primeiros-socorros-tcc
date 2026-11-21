depth=-y;visible=(global.missao==7||global.missao==8);
if(!visible||tcc_modal()||!instance_exists(obj_player))exit;
if(global.missao==7&&distance_to_object(obj_player)<56&&(keyboard_check_pressed(ord("E"))||tcc_touch_pressed(ord("E"))))tcc_iniciar_caso(3,"queimadura",9);
