if(shader_is_compiled(shd_mapa_nitido)) {
    var tex=sprite_get_texture(sprite_index,0);
    var uv=sprite_get_uvs(sprite_index,0);
    var tw=texture_get_texel_width(tex),th=texture_get_texel_height(tex);
    shader_set(shd_mapa_nitido);
    shader_set_uniform_f(shader_get_uniform(shd_mapa_nitido,"u_texel"),tw,th);
    shader_set_uniform_f(shader_get_uniform(shd_mapa_nitido,"u_bounds"),uv[0]+tw*0.5,uv[1]+th*0.5,uv[2]-tw*0.5,uv[3]-th*0.5);
    draw_self();shader_reset();
} else draw_self();

tcc_cobertura_mapa();
