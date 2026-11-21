function dentro_lista(_x,_y,_lista) {
    for(var i=0;i<array_length(_lista);i++){var r=_lista[i];if(point_in_rectangle(_x,_y,r[0],r[1],r[2],r[3]))return true;}
    return false;
}
function jogo_posicao_livre(_room,_x,_y) {
    if (_room==rm_hub) {
        if (_x<12 || _y<12 || _x>room_width-12 || _y>room_height-12) return false;
        static paredes = [[0, 0, 615, 418], [615, 0, 934, 284], [1135, 0, 1630, 296], [1078, 296, 1630, 638], [589, 380, 936, 690], [0, 535, 484, 965], [538, 736, 1023, 965], [1118, 650, 1630, 965], [420, 396, 481, 441], [24, 488, 67, 535], [938, 183, 975, 242], [1080, 205, 1117, 256], [1041, 436, 1077, 478], [854, 666, 908, 719], [489, 821, 527, 885], [1029, 830, 1068, 887]];
        for (var i=0; i<array_length(paredes); i++) {
            var r=paredes[i];
            if (_x+7>r[0] && _x-7<r[2] && _y>r[1] && _y-6<r[3]) return false;
        }
        return true;
    }
    var dados=interior_dados(_room);
    if(is_struct(dados)) {
        if(!dentro_lista(_x-6,_y-3,dados.piso) || !dentro_lista(_x+6,_y-3,dados.piso)) return false;
        for(var i=0;i<array_length(dados.moveis);i++){
            var r=dados.moveis[i];
            if(_x+7>r[0] && _x-7<r[2] && _y>r[1] && _y-6<r[3]) return false;
        }
    }
    return true;
}
function jogo_nome_room(_room) {
    if(_room==rm_hub)return "CORREDORES"; if(_room==rm_secretaria)return "SECRETARIA";
    if(_room==rm_cantina)return "CANTINA"; if(_room==rm_quadra)return "QUADRA";
    if(_room==rm_laboratorio)return "LABORATORIO"; if(_room==rm_enfermaria)return "ENFERMARIA";
    if(_room==rm_banheiros)return "BANHEIROS"; if(_room==rm_sala_aula)return "SALA DE AULA";
    if(_room==rm_treinamento)return "CENTRO DE TREINAMENTO"; return "ESCOLA";
}
function escola_area(_x,_y){return jogo_nome_room(room);}
function escola_destino(){
    switch(global.missao){
        case 0:case 3:case 6:case 9:case 12:case 110:return "SECRETARIA - PROFESSORA ANA";
        case 100:return "TREINAMENTO - MANUAL"; case 101:return "TREINAMENTO - AVALIACAO";
        case 102:return "TREINAMENTO - ENGASGO"; case 103:return "TREINAMENTO - ESTABILIZACAO";
        case 104:return "TREINAMENTO - PROVA FINAL"; case 1:case 2:return "CANTINA";
        case 31:case 61:case 91:return "ENFERMARIA"; case 4:case 5:return "QUADRA";
        case 7:case 8:return "LABORATORIO"; case 10:case 11:return "CORREDORES";
    } return "SIGA O PAINEL";
}
function treino_bloqueado(_texto){global.dialogo_titulo="Estacao bloqueada";global.dialogo_texto=_texto;global.dialogo_ativo=true;audio_play_sound(snd_erro,1,false);}

function escola_portas() {
    return [
        {nome:"SECRETARIA",x:745,y:712,destino:rm_secretaria,sx:237,sy:395},
        {nome:"TREINAMENTO",x:764,y:310,destino:rm_treinamento,sx:384,sy:300},
        {nome:"CANTINA",x:510,y:760,destino:rm_cantina,sx:480,sy:285},
        {nome:"QUADRA",x:320,y:450,destino:rm_quadra,sx:360,sy:430},
        {nome:"LABORATORIO",x:1050,y:540,destino:rm_laboratorio,sx:95,sy:252},
        {nome:"ENFERMARIA",x:1090,y:865,destino:rm_enfermaria,sx:98,sy:282},
        {nome:"BANHEIROS",x:790,y:710,destino:rm_banheiros,sx:270,sy:120},
        {nome:"SALA DE AULA",x:1105,y:285,destino:rm_sala_aula,sx:113,sy:363}
    ];
}

function interior_dados(_room){
    if(_room==rm_secretaria) return {piso:[[114, 110, 392, 329], [212, 315, 263, 425]],moveis:[[115, 151, 143, 184], [156, 145, 212, 186], [288, 145, 355, 185], [356, 179, 388, 219], [196, 205, 323, 265], [112, 239, 146, 268], [117, 289, 143, 325], [363, 254, 392, 282], [342, 308, 389, 329]]};
    if(_room==rm_cantina) return {piso:[[53, 80, 488, 469], [480, 253, 520, 314]],moveis:[[51, 144, 331, 194], [339, 128, 491, 179], [80, 255, 170, 347], [211, 238, 311, 340], [343, 238, 438, 345], [80, 374, 170, 447], [215, 374, 310, 449], [345, 374, 437, 449], [459, 441, 490, 470]]};
    if(_room==rm_laboratorio) return {piso:[[102, 78, 582, 326], [75, 223, 112, 284]],moveis:[[106, 147, 144, 177], [155, 125, 385, 155], [396, 127, 494, 155], [509, 128, 557, 156], [166, 215, 303, 261], [372, 214, 535, 262], [180, 272, 210, 297], [260, 272, 291, 297], [386, 272, 417, 297], [472, 272, 501, 297], [555, 186, 582, 212]]};
    if(_room==rm_enfermaria) return {piso:[[111, 90, 553, 356], [80, 257, 123, 307]],moveis:[[118, 153, 151, 182], [162, 156, 225, 226], [246, 174, 277, 226], [299, 152, 341, 184], [346, 150, 398, 186], [407, 150, 470, 185], [479, 150, 526, 185], [333, 277, 446, 317], [448, 277, 479, 323], [383, 309, 418, 337], [515, 312, 551, 346], [147, 328, 232, 359], [114, 340, 140, 358]]};
    if(_room==rm_banheiros) return {piso:[[97, 197, 230, 298], [244, 98, 299, 298], [321, 98, 375, 298], [390, 197, 514, 298], [214, 235, 264, 262], [354, 235, 411, 262]],moveis:[[100, 265, 228, 298], [392, 265, 510, 298], [268, 275, 298, 298], [323, 275, 354, 298]]};
    if(_room==rm_sala_aula) return {piso:[[125, 78, 548, 385], [90, 345, 140, 382]],moveis:[[143, 151, 205, 184], [205, 166, 237, 183], [275, 181, 384, 213], [421, 163, 452, 185], [524, 171, 548, 191], [524, 368, 548, 390], [176, 235, 235, 263], [176, 290, 235, 318], [176, 345, 235, 373], [267, 235, 326, 263], [267, 290, 326, 318], [267, 345, 326, 373], [357, 235, 416, 263], [357, 290, 416, 318], [357, 345, 416, 373], [449, 235, 508, 263], [449, 290, 508, 318], [449, 345, 508, 373]]};
    if(_room==rm_quadra) return {piso:[[63, 174, 637, 380], [336, 366, 385, 465]],moveis:[[67, 222, 94, 331], [598, 215, 629, 325], [174, 369, 258, 387], [370, 369, 488, 387]]};
    if(_room==rm_treinamento) return {piso:[[75, 132, 690, 306], [360, 303, 405, 381]],moveis:[[75, 258, 156, 306], [160, 286, 187, 307], [76, 182, 115, 232], [189, 186, 238, 264], [246, 197, 283, 270], [369, 250, 452, 288], [522, 230, 637, 270], [373, 132, 474, 163], [107, 120, 177, 136], [184, 121, 219, 135], [246, 130, 283, 153], [536, 119, 652, 136], [665, 208, 693, 253], [666, 271, 692, 293], [671, 137, 694, 154]]};
    return undefined;
}
function personagens_livres(_x,_y){
    var tipos=[obj_profesora,obj_npc_ajudante,obj_aluno_engasgado,obj_aluno_desmaiado,obj_aluno_queimado,obj_aluno_caido];
    for(var t=0;t<array_length(tipos);t++){
        var tipo=tipos[t];
        if(tipo==obj_aluno_engasgado && global.missao!=1 && global.missao!=2) continue;
        if(tipo==obj_aluno_desmaiado && global.missao!=4 && global.missao!=5) continue;
        if(tipo==obj_aluno_queimado && global.missao!=7 && global.missao!=8) continue;
        if(tipo==obj_aluno_caido && global.missao!=10 && global.missao!=11) continue;
        for(var n=0;n<instance_number(tipo);n++){
            var npc=instance_find(tipo,n);
            var caido=(tipo==obj_aluno_desmaiado || tipo==obj_aluno_caido);
            var rx=caido?26:17, ry=caido?15:10;
            if(sqr((_x-npc.x)/rx)+sqr((_y-npc.y)/ry)<1) return false;
        }
    }
    return true;
}
