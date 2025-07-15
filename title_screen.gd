extends Node2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _on_button_pressed() -> void:
	audio_stream_player.play()
	LevelManager.next_scene()

func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
