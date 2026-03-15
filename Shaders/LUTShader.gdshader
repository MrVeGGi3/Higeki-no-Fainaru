shader_type canvas_item;

uniform sampler2D lut_texture : filter_nearest;
uniform float strength : hint_range(0.0, 1.0) = 1.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
	float lut_size = 16.0;
	float blue = color.b * (lut_size - 1.0);
	
	vec2 lut_pos = vec2(
		(floor(blue) / lut_size) + (color.r * (lut_size - 1.0) /(lut_size * lut_size)),
		color.g * (lut_size - 1.0) / lut_size	
	);
	
	vec4 graded_color  = texture(lut_texture, lut_pos);
	COLOR = mix(color, graded_color, strength);
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
