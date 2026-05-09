shader_type spatial;
render_mode unshaded;
uniform float waveStrength;
uniform float noiseScale;
uniform vec2 tileSpeed;

uniform float noiseScaleMult;
uniform vec2 tileSpeedMultiply;

uniform sampler2D gradient;



varying float lavaHeightValue;

vec2 random(vec2 uv){
    uv = vec2( dot(uv, vec2(127.1,311.7) ),
               dot(uv, vec2(269.5,183.3) ) );
    return -1.0 + 2.0 * fract(sin(uv) * 43758.1453023);
}

float noise(vec2 uv) {
    vec2 uv_index = floor(uv);
    vec2 uv_fract = fract(uv);

    vec2 blur = smoothstep(0.0, 1.0, uv_fract);
	blur = clamp(blur,0.0,1.0);

    return mix( mix( dot( random(uv_index + vec2(0.0,0.0) ), uv_fract - vec2(0.0,0.0) ),
                     dot( random(uv_index + vec2(1.0,0.0) ), uv_fract - vec2(1.0,0.0) ), blur.x),
                mix( dot( random(uv_index + vec2(0.0,1.0) ), uv_fract - vec2(0.0,1.0) ),
                     dot( random(uv_index + vec2(1.0,1.0) ), uv_fract - vec2(1.0,1.0) ), blur.x), blur.y) + 0.5;
}


void vertex() {
	vec3 world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	vec3 coordinate = world_position;
	coordinate *= vec3(noiseScale);
	
	vec3 tileTime = vec3(tileSpeed.r, 0.0, tileSpeed.g) * TIME;
	vec3 waveTime = sin(tileTime);
	vec3 noise1Coordinate = coordinate + waveTime;
	float noise1 = noise(vec2(noise1Coordinate.r,noise1Coordinate.b));
	
	vec3 coordinate2 = world_position * vec3(noiseScaleMult);
	vec3 tileTime2 = vec3(tileSpeedMultiply.r, 0.0, tileSpeedMultiply.g) * TIME;
	vec3 waveTime2 = sin(tileTime2);
	vec3 noise2Coordinate = coordinate2 + waveTime2;
	float noise2 = noise(vec2(noise2Coordinate.r,noise2Coordinate.b));;
	
	lavaHeightValue = noise1 * noise2;
	lavaHeightValue = clamp(lavaHeightValue,0.0,1.0);
	VERTEX.y += noise1 * waveStrength;
}

void fragment() {
	
	ALBEDO = texture(gradient,vec2(lavaHeightValue)).rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
