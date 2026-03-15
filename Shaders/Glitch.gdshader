shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float shake_power = 0.03;
uniform float shake_rate = 0.2;
uniform float shake_speed = 5.0;
uniform float shake_block_size = 30.5;
uniform float color_drift = 0.5;

float random(float seed){
	return fract(sin(dot(vec2(seed), vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
	float enable_shift = float(random(trunc(TIME * shake_speed)) < shake_rate);
	vec2 fixed_uv = SCREEN_UV;
	if(enable_shift > 0.5){
		fixed_uv.x += (random(trunc(SCREEN_UV.y * shake_block_size)) - 0.5) * shake_power;
	}
	vec4 pixel_color = texture(SCREEN_TEXTURE, fixed_uv);
	pixel_color.r = texture(SCREEN_TEXTURE, fixed_uv + vec2(color_drift * 0.01, 0.0)).r;
	pixel_color.b = texture(SCREEN_TEXTURE, fixed_uv - vec2(color_drift * 0.01, 0.0)).b;
	
	COLOR = pixel_color;
}	 

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
