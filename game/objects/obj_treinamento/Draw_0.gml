if(global.dialogo_ativo) exit;
if(instance_exists(obj_room_manager) && obj_room_manager.entrada_cooldown>0) exit;
var pontos=[[171,267],[228,282],[414,300],[585,285],[414,174]];
var nomes=["MANUAL","AVALIACAO","ENGASGO","ESTABILIZACAO","PROVA FINAL"];
for(var i=0;i<array_length(pontos);i++) {
    if(point_distance(obj_player.x,obj_player.y,pontos[i][0],pontos[i][1])<39){
        if(point_distance(obj_player.x,obj_player.y,384,309)<point_distance(obj_player.x,obj_player.y,pontos[i][0],pontos[i][1])) break;
        draw_set_halign(fa_center);draw_set_color(c_white);
        tcc_draw_text(obj_player.x,obj_player.y-78,"[E] "+nomes[i]);draw_set_halign(fa_left);break;
    }
}
