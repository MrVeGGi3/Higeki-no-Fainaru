shader_type canvas_item;

uniform float shake_power = 0.01;
uniform float shake_rate = 1.0;
uniform float shake_speed = 5.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

float random(float seed) {
    return fract(sin(dot(vec2(seed), vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    vec2 fixed_uv = SCREEN_UV;
    // Gera um deslocamento aleatório baseado no tempo
    fixed_uv.x += (random(trunc(TIME * shake_speed)) - 0.5) * shake_power * shake_rate;
    fixed_uv.y += (random(trunc(TIME * shake_speed + 1.0)) - 0.5) * shake_power * shake_rate;
    
    COLOR = texture(SCREEN_TEXTURE, fixed_uv);
}