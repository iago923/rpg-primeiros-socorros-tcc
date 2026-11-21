if(entrada_cooldown>0){entrada_cooldown--;exit;}
prompt_porta=false;
if(tcc_modal())exit;
if (!instance_exists(obj_player)) exit;
if (global.dialogo_ativo || global.intro_ativo) exit;
var portas=escola_portas();
var escolhido=-1, distancia=100000;
for(var i=0;i<array_length(portas);i++) {
    var p=portas[i];
    if (room!=rm_hub && room!=p.destino) continue;
    var tx=(room==rm_hub)?p.x:p.sx;
    var ty=(room==rm_hub)?p.y:p.sy;
    if(room==rm_treinamento) ty=309;
    var d=point_distance(obj_player.x,obj_player.y,tx,ty);
    if(d<distancia){distancia=d;escolhido=i;}
}
if(escolhido<0 || distancia>38) exit;
if(room==rm_treinamento){
    var estacoes=[[171,267],[228,282],[414,300],[585,285],[414,174]];
    for(var k=0;k<array_length(estacoes);k++)
        if(point_distance(obj_player.x,obj_player.y,estacoes[k][0],estacoes[k][1])<distancia) exit;
}
var p=portas[escolhido];
prompt_porta=true;
prompt_nome=(room==rm_hub)?p.nome:"CORREDOR";
if(!keyboard_check_pressed(ord("E"))&&!tcc_touch_pressed(ord("E"))) exit;
if(room==rm_hub && p.destino==rm_treinamento && global.missao<100 && !global.capacitado) {
    global.dialogo_titulo="Sala de treinamento";
    global.dialogo_texto="Fale com a professora Ana na secretaria para iniciar sua capacitacao.";
    global.dialogo_ativo=true;
    exit;
}
global.spawn_x=(room==rm_hub)?p.sx:p.x;
global.spawn_y=(room==rm_hub)?p.sy:p.y;
global.spawn_pendente=true;
room_goto((room==rm_hub)?p.destino:rm_hub);
