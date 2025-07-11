extends CanvasLayer

var next_scene: PackedScene
var scene_params: Dictionary

@onready var animation_player = $AnimationPlayer

func start_transition(scene: PackedScene, new_scene_params: Dictionary = {}) -> void:
	next_scene = scene
	scene_params = new_scene_params
	animation_player.play("swipe_in_out")

func _change_scene():
	var new_scene = next_scene.instantiate()
	# Initiate it if possible
	if new_scene.has_method("init_level"):
		new_scene.init_level(scene_params)
	
	# Replace current scene
	get_tree().current_scene.queue_free()
	get_tree().root.add_child(new_scene)
	get_tree().set_current_scene(new_scene)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "swipe_in_out":
		queue_free()
