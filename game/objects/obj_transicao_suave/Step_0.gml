alpha_transicao = max(0, alpha_transicao - delta_time/1000000*(global.cfg.reduced?5:2.5));
if (alpha_transicao <= 0) instance_destroy();
