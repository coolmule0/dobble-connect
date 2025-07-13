extends Node2D


func _on_button_pressed() -> void:
	LevelManager.next_scene()

func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
