vel = 2.35;
sentado = false;
cooldown_sentar = 0;
escala_visual = 1.15;

sprite_index = spr_player_final_baixo;
image_speed = 0;
image_xscale = escala_visual;
image_yscale = escala_visual;



if (variable_global_exists("spawn_pendente") && global.spawn_pendente) { x=global.spawn_x; y=global.spawn_y; global.spawn_pendente=false; }

fase_passos=0;
passos_ativo=false;

switch(global.tcc_facing){case "cima":sprite_index=spr_player_final_cima;break;case "esquerda":sprite_index=spr_player_final_esquerda;break;case "direita":sprite_index=spr_player_final_direita;break;}
