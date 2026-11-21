if (!instance_exists(obj_player)) exit;
draw_set_halign(fa_center);
if(room==rm_hub) {
    var portas=escola_portas();
    var proxima=-1, menor=140;
    for(var j=0;j<array_length(portas);j++){
        var d=point_distance(obj_player.x,obj_player.y,portas[j].x,portas[j].y);
        if(d<menor){menor=d;proxima=j;}
    }
    for(var i=0;i<array_length(portas);i++) {
        if(i!=proxima) continue;
        var p=portas[i];
        draw_set_color(c_black);
        tcc_draw_text(p.x+1,p.y-17,p.nome);
        draw_set_color(c_white);
        tcc_draw_text(p.x,p.y-18,p.nome);
    }
}
if(prompt_porta) {
    draw_set_color(c_black);
    tcc_draw_text(obj_player.x+1,obj_player.y-73,"[E] "+prompt_nome);
    draw_set_color(c_white);
    tcc_draw_text(obj_player.x,obj_player.y-74,"[E] "+prompt_nome);
}
draw_set_halign(fa_left);
