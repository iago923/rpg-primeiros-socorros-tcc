if(global.intro_ativo || global.dialogo_ativo || !instance_exists(obj_player)) exit;
var destino=escola_destino();
var portas=escola_portas();
var alvo=-1;
for(var i=0;i<array_length(portas);i++) {
    if(string_pos(portas[i].nome,destino)>0){alvo=i;break;}
}
if(alvo<0) exit;
var p=portas[alvo];
var tx=p.x, ty=p.y, legenda=p.nome;
if(room!=rm_hub) {
    if(room==p.destino) exit;
    for(var i=0;i<array_length(portas);i++) {
        if(room==portas[i].destino){tx=portas[i].sx;ty=portas[i].sy;}
    }
    if(room==rm_treinamento) ty=309;
    legenda="SAIDA PARA O CORREDOR";
}
var ang=point_direction(obj_player.x,obj_player.y,tx,ty);
var gx=display_get_gui_width()*0.5, gy=display_get_gui_height()-120;
draw_set_alpha(0.85);draw_set_color(c_black);
draw_rectangle(gx-175,gy-24,gx+175,gy+40,false);
draw_set_alpha(1);draw_set_color(make_color_rgb(255,220,95));
draw_arrow(gx-140,gy+8,gx-140+lengthdir_x(22,ang),gy+8+lengthdir_y(22,ang),8);
draw_set_halign(fa_center);tcc_draw_text(gx+10,gy,legenda);draw_set_halign(fa_left);
draw_set_color(c_white);
