if(variable_instance_exists(id,"owns_tcc")&&owns_tcc){
 ds_list_destroy(global.bolsa);ds_list_destroy(global.armario);
 if(global.font_body>=0)font_delete(global.font_body);
 if(global.font_large>=0)font_delete(global.font_large);
 if(global.font_title>=0)font_delete(global.font_title);
}
