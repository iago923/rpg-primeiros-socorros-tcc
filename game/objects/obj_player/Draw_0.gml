// Complete poses from the original sheet, with one shared ground anchor.
var box=[164,23,309,554];
if(sprite_index==spr_player_final_cima)box=[764,11,295,583];
if(sprite_index==spr_player_final_esquerda)box=[173,604,289,645];
if(sprite_index==spr_player_final_direita)box=[760,605,286,658];
var sc=(46/box[3])*escala_visual;
var px=round(x),py=round(y);
var left=px-box[2]*sc*0.5;
var top=py-box[3]*sc;
var moving=passos_ativo && !global.dialogo_ativo && !global.intro_ativo;
var phase=moving?sin(fase_passos):0;
draw_set_alpha(0.15);draw_set_color(c_black);
draw_ellipse(px-10,py-3,px+10,py+3,false);
draw_set_alpha(1);draw_set_color(c_white);
var filter_before=gpu_get_texfilter();gpu_set_texfilter(true);
if(!moving) {
    draw_sprite_part_ext(spr_player_fonte,0,box[0],box[1],box[2],box[3],left,top,sc,sc,c_white,1);
} else {
    // Alternate the two legs below the knee; overlap their seam under the torso.
    var split=floor(box[3]*0.80);
    var half=floor(box[2]*0.5), lower=box[3]-split;
    for(var side=0;side<2;side++) {
        var shift=phase*(side==0?1:-1)*1.0;
        var width=(side==0)?half:box[2]-half;
        var legscale=(lower*sc+shift)/(lower*sc);
        draw_sprite_part_ext(spr_player_fonte,0,box[0]+side*half,box[1]+split,width,lower,
            left+side*half*sc,top+split*sc,sc,sc*legscale,c_white,1);
    }
    draw_sprite_part_ext(spr_player_fonte,0,box[0],box[1],box[2],split+1,left,top,sc,sc,c_white,1);
}
gpu_set_texfilter(filter_before);
