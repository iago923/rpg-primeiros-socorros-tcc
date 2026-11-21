if(async_load[?"id"]!=global.tcc_request||async_load[?"status"]==1)exit;
if(async_load[?"status"]<0){global.tcc_busy=false;global.tcc_new_pending=false;global.tcc_return_menu=false;global.tcc_notice="Banco indisponível; não foi salvo. Inicie o serviço e tente novamente.";exit;}
try{tcc_process_response(json_parse(async_load[?"result"]));}
catch(err){global.tcc_busy=false;global.tcc_notice="Resposta inválida do banco; não foi confirmado salvamento.";global.tcc_new_pending=false;global.tcc_return_menu=false;}
