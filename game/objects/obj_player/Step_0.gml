passos_ativo=false;
if(tcc_modal()){image_speed=0;exit;}
if (cooldown_sentar > 0) cooldown_sentar--;

if (sentado) {
    image_speed = 0;
    image_index = 0;
    image_xscale = escala_visual;
    image_yscale = escala_visual;
    if (keyboard_check_pressed(ord("E"))||tcc_touch_pressed(ord("E"))) {
        sentado = false;
        cooldown_sentar = 15;
        y += 20;
    }
    exit;
}

if ((variable_global_exists("dialogo_ativo") && global.dialogo_ativo) || global.intro_ativo) {image_speed=0;exit;}

var h = (((keyboard_check(ord("D")) || keyboard_check_pressed(ord("D"))) || (keyboard_check(vk_right) || keyboard_check_pressed(vk_right))) - ((keyboard_check(ord("A")) || keyboard_check_pressed(ord("A"))) || (keyboard_check(vk_left) || keyboard_check_pressed(vk_left))))+global.tcc_touch_h;
var v = (((keyboard_check(ord("S")) || keyboard_check_pressed(ord("S"))) || (keyboard_check(vk_down) || keyboard_check_pressed(vk_down))) - ((keyboard_check(ord("W")) || keyboard_check_pressed(ord("W"))) || (keyboard_check(vk_up) || keyboard_check_pressed(vk_up))))+global.tcc_touch_v;
h=clamp(h,-1,1);v=clamp(v,-1,1);
var andando = (h != 0 || v != 0);

if (andando) {
    var tamanho = point_distance(0, 0, h, v);
    h = (h / tamanho) * vel;
    v = (v / tamanho) * vel;

    if (abs(h) > abs(v)) {
        sprite_index = (h > 0) ? spr_player_final_direita : spr_player_final_esquerda;
    } else {
        sprite_index = (v > 0) ? spr_player_final_baixo : spr_player_final_cima;
    }

    image_speed = 0.22;
    var antes_x=x, antes_y=y;
    var novo_x = x + h;
    var novo_y = y + v;

    var livre_x = (jogo_posicao_livre(room,novo_x,y) && personagens_livres(novo_x,y));
    if (livre_x) x=novo_x;
    var livre_y=(jogo_posicao_livre(room,x,novo_y) && personagens_livres(x,novo_y));
    if (livre_y) y=novo_y;

    passos_ativo=(x!=antes_x || y!=antes_y);
    if(passos_ativo) fase_passos+=point_distance(antes_x,antes_y,x,y)*0.18;
    else image_speed=0;
    image_xscale=escala_visual;
    image_yscale=escala_visual;
} else {
    image_speed = 0;
    image_index = 0;
    image_xscale = escala_visual;
    image_yscale = escala_visual;
}

global.local_atual=jogo_nome_room(room);

depth=-y;
