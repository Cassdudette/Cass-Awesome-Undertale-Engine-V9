shader_type spatial;

uniform sampler2D uTexture;

vec4 gaussianBlur(sampler2D source, vec2 uv, int samples, float amount) {
	vec4 color = texture(source, uv);
	amount *= .015;

	for (int i = 1; i < samples; i++) {
		float offset_x = sin(float(i) * 3.14 / amount) * amount - amount;
		float offset_y = cos(float(i) * 3.14 / amount) * amount + amount;

		color += texture(source, uv + vec2(offset_x, offset_y));
	}

	color = color / float(samples);

	return color;
}

void fragment() {
	ALBEDO = gaussianBlur(uTexture, UV, 12, 1).rgb;
}
