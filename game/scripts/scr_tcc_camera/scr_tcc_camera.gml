function tcc_limites_visuais(){
 if(room==rm_secretaria)return [70,42,426,425];
 if(room==rm_cantina)return [10,20,525,510];
 if(room==rm_laboratorio)return [60,22,618,365];
 if(room==rm_enfermaria)return [70,32,589,394];
 if(room==rm_banheiros)return [60,45,550,336];
 if(room==rm_sala_aula)return [85,22,585,425];
 if(room==rm_quadra)return [20,35,680,465];
 if(room==rm_treinamento)return [40,24,725,400];
 return [0,0,room_width,room_height];
}
function tcc_camera(){
 var cam=view_camera[0];if(cam<0||!instance_exists(obj_player))return;
 camera_set_view_target(cam,noone);camera_set_view_size(cam,640,360);
 var b=tcc_limites_visuais(),w=b[2]-b[0],h=b[3]-b[1];
 var cx=w<=640?(b[0]+b[2]-640)/2:clamp(obj_player.x-320,b[0],b[2]-640);
 var cy=h<=360?(b[1]+b[3]-360)/2:clamp(obj_player.y-180,b[1],b[3]-360);
 camera_set_view_pos(cam,round(cx),round(cy));
}
function tcc_cobertura_mapa(){
 var previous=draw_get_color();draw_set_color(c_black);
 if(room==rm_hub){
  // Only interiors are covered; existing outer walls, doors and colliders remain.
  var interiors=[[22,18,604,343],[639,17,912,212],[1169,24,1599,341],[1116,357,1597,613],[624,398,912,619],[0,552,451,945],[571,752,987,944],[1152,671,1598,944]];
  for(var i=0;i<array_length(interiors);i++){var r=interiors[i];draw_rectangle(r[0],r[1],r[2],r[3],false);}
 }else{
  var b=tcc_limites_visuais();
  draw_rectangle(-2000,-2000,room_width+2000,b[1],false);
  draw_rectangle(-2000,b[3],room_width+2000,room_height+2000,false);
  draw_rectangle(-2000,b[1],b[0],b[3],false);
  draw_rectangle(b[2],b[1],room_width+2000,b[3],false);
 }
 draw_set_color(previous);
}
