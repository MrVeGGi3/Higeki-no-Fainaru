shader_type canvas_item;

uniform float offset : hint_range(0.0, 5.0) = 1.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;


void fragment() {
	vec2 shift =  vec2(offset * SCREEN_PIXEL_SIZE.x, 0.0);
	float r = texture(SCREEN_TEXTURE, SCREEN_UV - shift).r;
	float g = texture(SCREEN_TEXTURE, SCREEN_UV).g;
	float b = texture(SCREEN_TEXTURE, SCREEN_UV + shift).b;
	
	COLOR = vec4(r, g, b, 1.0);
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
