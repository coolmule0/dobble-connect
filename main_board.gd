extends Node2D

@onready var pc: Character = $PC
@onready var character: Character = $Character

var drawing = false
var start_pos = Vector2.ZERO

@onready var line = $Line2D

func _ready() -> void:
	#trait_container.connect("mouseclick", _on_child_clicked)
	pc.connect("mouseclick", _on_area_clicked)
	character.connect("mouseclick", _on_area_clicked)

func _on_area_clicked(global_pos):
	start_pos = global_pos
	drawing = true
	line.clear_points()
	line.add_point(start_pos)
	line.add_point(start_pos)  # Add dummy second point to start

func _process(delta):
	if drawing:
		line.set_point_position(1, get_global_mouse_position())

func _input(event):
	if drawing and event is InputEventMouseButton and not event.pressed:
		drawing = false
		line.clear_points()
