shader_type canvas_item;

uniform float radius : hint_range(0.1, 2.0) = 0.9;
uniform float thickness : hint_range(0.01, 1.0) = 0.2;
uniform float bend_strength : hint_range(0.0, 10.0) = 4.0;
uniform vec4 banana_color : source_color = vec4(1.0, 1.0, 0.2, 1.0);

void fragment() {
    vec2 uv = UV * 2.0 - 1.0; // Normalize UV to range [-1, 1]
    uv.x *= (SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y); // Aspect correction

    // Map x to angle range: 0 to PI
    float angle = uv.x * 3.14159 * 0.5; // from -PI/2 to PI/2

    // Parametric banana arc
    vec2 arc_center = vec2(sin(angle), -cos(angle)); // Semi-circle curve
    arc_center *= radius;

    // Measure distance from actual fragment to the arc
    float dist = length(uv - arc_center);

    // Band thickness
    float outer = thickness * 0.5;
    float inner = -thickness * 0.5;

    // Smooth edge
    float edge = fwidth(dist);
    float alpha_outer = smoothstep(outer, outer - edge, dist);
    float alpha_inner = 1.0 - smoothstep(inner, inner + edge, dist);
    float alpha = alpha_outer * alpha_inner;

    // Output banana color
    COLOR = banana_color * alpha;
}
