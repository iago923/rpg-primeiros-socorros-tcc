if(room!=rm_menu)global.segundos+=min(delta_time/1000000,0.1);
global.tcc_touch_h=0;global.tcc_touch_v=0;
var _old_e=global.tcc_touch_e_down,_old_space=global.tcc_touch_space_down;
global.tcc_touch_e_down=false;global.tcc_touch_space_down=false;
var _old_pause=global.tcc_touch_pause_pressed;global.tcc_touch_pause_pressed=false;
if(tcc_web_target()&&room!=rm_menu&&global.tcc_panel==""&&!global.tcc_busy&&device_mouse_check_button(0,mb_left)){
 var _mx=device_mouse_x_to_gui(0),_my=device_mouse_y_to_gui(0);
 if(!global.dialogo_ativo&&!global.intro_ativo){
  if(point_in_rectangle(_mx,_my,45,525,105,585))global.tcc_touch_v=-1;
  else if(point_in_rectangle(_mx,_my,105,585,165,645))global.tcc_touch_h=-1;
  else if(point_in_rectangle(_mx,_my,165,585,225,645))global.tcc_touch_h=1;
  else if(point_in_rectangle(_mx,_my,105,645,165,705))global.tcc_touch_v=1;
  global.tcc_touch_e_down=point_distance(_mx,_my,1170,585)<46;
 }
 global.tcc_touch_space_down=point_distance(_mx,_my,1060,642)<48;
 global.tcc_touch_pause_pressed=point_distance(_mx,_my,1220,72)<30&&!_old_pause;
}
global.tcc_touch_e_pressed=global.tcc_touch_e_down&&!_old_e;
global.tcc_touch_space_pressed=global.tcc_touch_space_down&&!_old_space;
if(global.tcc_busy){
 global.tcc_wait+=delta_time/1000000;
 if(global.tcc_wait>8){global.tcc_busy=false;global.tcc_request=-1;global.tcc_new_pending=false;global.tcc_return_menu=false;global.tcc_notice="Banco indisponível. Inicie Servidor.exe e tente novamente. Não foi confirmado salvamento.";}
}
tcc_ui_step();
if(global.tcc_notice!=global.tcc_notice_last){global.tcc_notice_last=global.tcc_notice;global.tcc_notice_time=7;}
if(global.tcc_notice_time>0&&!global.tcc_busy){
 global.tcc_notice_time-=delta_time/1000000;
 if(global.tcc_notice_time<=0)global.tcc_notice="";
}
if(global.tcc_save_cooldown>0)global.tcc_save_cooldown-=delta_time/1000000;
if(room!=rm_menu&&global.tcc_dirty&&!tcc_modal()&&!is_struct(global.tcc_case)&&global.tcc_save_cooldown<=0){global.tcc_save_cooldown=30;tcc_salvar();}
