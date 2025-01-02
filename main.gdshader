shader_type canvas_item;

uniform sampler2D a;
uniform sampler2D b;
uniform sampler2D c;

void fragment() {
	vec3 ta = texture(a, UV).rgb;
	vec3 tb = texture(b, UV).rgb;
	vec3 tc = texture(c, UV).rgb;

	float d = mod(TIME, 9);

	vec3 col = mix(mix(mix(ta, tb, clamp(d, 0.0, 1.0)), tc, clamp(d-3.0, 0.0, 1.0)), ta, clamp(d-6.0, 0.0, 1.0));

	COLOR = vec4(col, 1.0);
}
