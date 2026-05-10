shader_type spatial;
render_mode unshaded;

uniform sampler2D mask;
uniform vec4 inputCol;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	
	ALBEDO = texture(mask,UV).rgb;
	ALBEDO *= inputCol.rgb;
	ALPHA = texture(mask,UV).r;
	ALPHA -= inputCol.a;

	
	
	EMISSION = texture(mask, UV).rgb;
	EMISSION *= inputCol.rgb;
	EMISSION *= inputCol.a;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
