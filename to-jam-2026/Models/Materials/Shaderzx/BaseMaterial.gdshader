shader_type spatial;
render_mode unshaded;

uniform sampler2D mainTexture;
uniform float brightnessMult;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 baseColor = texture(mainTexture, UV);
	ALBEDO = baseColor.rgb * brightnessMult;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
