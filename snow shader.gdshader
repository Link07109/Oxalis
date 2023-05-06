shader_type canvas_item;

float snow(vec2 uv, float scale) {
	float w = smoothstep(1.0, 0.0, -uv.y * (scale/10.0));
	if (w < 0.1) return 0.0;
	uv += TIME * 2.0 / scale;
	uv.x += sin(uv.y + TIME * 0.5) / scale;
	uv *= scale;
	vec2 s = floor(uv);
	vec2 f = fract(uv);
	vec2 p = vec2(0, 0);
	float k = 3.0;
	float d;
	vec2 t = (s + p + vec2(scale)) * mat2(vec2(7.0, 3.0), vec2(6.0, 5.0));
	vec2 t1 = 11.0 * fract(vec2(sin(t.x), sin(t.y)));
	p = vec2(0.5) + 0.35 * vec2(sin(t1.x), sin(t1.y)) - f;
	d = length(p);
	k = min(d, k);
	k = smoothstep(0.0, k, sin(f.x + f.y) * 0.01);
	return k * w;
}

void fragment() {
	float col1 = 0.0;
	vec4 col2 = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0);
	vec2 uv = (vec2(1.0) - UV) / (vec2(2) - vec2(1.0));
	col1 += snow(uv, 30.0) * 0.3;
	col1 += snow(uv, 20.0) * 0.5;
	col1 += snow(uv, 15.0) * 0.8;
	col1 += snow(uv, 10.0);
	col1 += snow(uv, 8.0);
	col1 += snow(uv, 6.0);
	col1 += snow(uv, 5.0);

	COLOR = vec4(vec3(col1), 1.0) + col2;
}