shader_type canvas_item;


uniform float multiplier = 0.2;
uniform float softness = 3.0;
uniform float radius = 0.5;
uniform vec4 vignette_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);


void fragment() {
	float value =  distance(UV, vec2(0.5));
	float vignette = smoothstep(radius, radius - softness, value);
	
	COLOR = vec4(vignette_color.rgb, (1.0 - vignette) * multiplier);
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
