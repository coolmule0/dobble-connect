extends Control

@export var radius: float = 80.0
@export var arc_angle: float = PI  # Half circle
@export var arc_offset: float = -PI / 2  # Start angle (top center)
@export var color: Color = Color(1, 1, 1, 0.8)
@export var outline_color: Color = Color(0, 0, 0)
@export var outline_width: float = 2.0

func _draw():
	var center = Vector2(size.x / 2, size.y)  # Bubble base at bottom center
	var points = []

	var segments = 64
	for i in range(segments + 1):
		var angle = arc_offset + (i / segments) * arc_angle
		var point = center + Vector2(radius * cos(angle), -radius * sin(angle))
		points.append(point)

	# Close shape back to the base center
	points.append(center)

	draw_colored_polygon(points, color)
	draw_polyline(points, outline_color, outline_width)
