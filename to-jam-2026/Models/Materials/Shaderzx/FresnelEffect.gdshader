shader_type spatial;
render_mode unshaded;

uniform sampler2D texture_albedo;
uniform float fresnelStrength;
uniform vec4 fresnelColor;


void vertex() {
	// Called for every vertex the material is visible on.
}

float fresnel(float amount, vec3 normal, vec3 view)
{
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0 )), amount);
}

void fragment()
{
	vec4 base_color = texture(texture_albedo, UV);
	
	float basic_fresnel = fresnel(fresnelStrength, NORMAL, VIEW);
	vec4 fresnel_color = fresnelColor * basic_fresnel;
	ALBEDO = base_color.rgb + fresnel_color.rgb;
}


//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
