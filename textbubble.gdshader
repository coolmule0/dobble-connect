shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

//uniform float curve_strength : hint_range(-1.0, 1.0) = 0.2;

void fragment() {
    vec2 uv = UV;

    // Convert to [-1, 1] range
    vec2 centered = uv * 2.0 - vec2(1.0, 1.0);

    // Polar coordinate conversion
    float r = length(centered);
    float theta = atan(centered.y, centered.x);

    // Limit to semi-circle
    if (theta < -1.57 || theta > 1.57 || r > 1.0) {
        discard; // Transparent outside semi-circle
    }

    // Warp UVs from polar back to rectangular sample space
    vec2 warped_uv = vec2((theta + 1.57) / 3.14, r);

    // Use warped UVs to sample original texture
    COLOR = texture(TEXTURE, warped_uv);
}
