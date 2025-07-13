extends Node2D

@onready var pc: Character = $PC
@onready var character: Character = $Character

@export var pc_traits: Array[CompressedTexture2D]
@export var npc_traits: Array[CompressedTexture2D]
@onready var label_score: Label = %Score

var is_drawing = false
var start_pos = Vector2.ZERO
var start_source: Node2D = null

@onready var line = $Line2D

## Handle mouse clicking and connecting the connection traits
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var clicked = get_connectable_at_mouse()
				if clicked:
					start_pos = get_global_mouse_position()
					start_source = clicked
					is_drawing = true
					line.clear_points()
					line.add_point(start_pos)
					line.add_point(start_pos)
			else:
				if is_drawing:
					var released = get_connectable_at_mouse()
					if released and released != start_source:
						#print("Connected from %s to %s" % [start_source.name, released.name])
						is_drawing = false
						_check_connection(start_source.get_owner(), released.get_owner())
					else:
						print("Connection canceled")
						is_drawing = false
						line.clear_points()
						start_source = null
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _process(delta):
	if is_drawing:
		line.set_point_position(1, get_global_mouse_position())

func get_connectable_at_mouse():
	var space = get_world_2d().direct_space_state
	var param2d := PhysicsPointQueryParameters2D.new()
	param2d.position = get_global_mouse_position()
	param2d.collide_with_areas = true
	param2d.collide_with_bodies = false

	var result = space.intersect_point(param2d)
	

	for item in result:
		if item.collider.is_in_group("Connectable"):
			return item.collider
	return null

## Are two traits valid connections?
func _check_connection(start_trait: TraitContainer, end_trait: TraitContainer):
	# TODO: possibly check owner to ensure initialtes from 2 different character
	if start_trait.trait_sprite == end_trait.trait_sprite:
		print("Correct!")
		# turn line green. move on
		var twe = create_tween()
		twe.tween_property(line, "modulate", Color.GREEN, 0.15)
		LevelManager.score += 1
		LevelManager.next_scene()
	else:
		print("Not Right!")
		# turn line red and shake
		var twe = create_tween()
		var line_col = line.get_default_color()
		line.default_color = Color.RED
		#twe.tween_property(line, "modulate", Color.RED, 0.15)
		for i in range(3):
			twe.tween_property(line, "position:x", -5, 0.05)
			twe.tween_property(line, "position:x", 5, 0.05)
		twe.tween_callback(line.clear_points)
		twe.tween_property(line, "default_color", line_col, 0.01)
		#line.default_color = line_col

func init_level(init_vars: Dictionary) -> void:
	pc_traits = init_vars["pc"]
	npc_traits = init_vars["npc"]
	(func(): pc.traits = pc_traits).call_deferred()
	(func(): character.traits = npc_traits).call_deferred()
	#call_deferred("init_level_after_ready")

#func init_level_after_ready() -> void:
	#pc.traits = pc_traits
	#character.traits = npc_traits

func _ready() -> void:
	label_score.text = str(LevelManager.score)
