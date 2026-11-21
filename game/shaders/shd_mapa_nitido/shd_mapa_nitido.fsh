varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec2 u_texel;
uniform vec4 u_bounds;
vec3 read_pixel(vec2 uv){return texture2D(gm_BaseTexture,clamp(uv,u_bounds.xy,u_bounds.zw)).rgb;}
void main(){
    vec4 base=texture2D(gm_BaseTexture,v_vTexcoord);
    vec3 blur=(read_pixel(v_vTexcoord+vec2(u_texel.x,0.0))+read_pixel(v_vTexcoord-vec2(u_texel.x,0.0))
             +read_pixel(v_vTexcoord+vec2(0.0,u_texel.y))+read_pixel(v_vTexcoord-vec2(0.0,u_texel.y)))*0.25;
    vec3 detail=clamp(base.rgb-blur,vec3(-0.10),vec3(0.10));
    vec3 color=clamp(base.rgb+detail*0.70,0.0,1.0);
    float luma=dot(color,vec3(0.299,0.587,0.114));
    color=mix(vec3(luma),color,1.035);
    gl_FragColor=v_vColour*vec4(clamp(color,0.0,1.0),base.a);
}
