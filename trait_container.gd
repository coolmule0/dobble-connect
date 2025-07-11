@tool
class_name TraitContainer
extends Marker2D

@export var trait_sprite: CompressedTexture2D : set = set_trait_sprite

@onready var sprite_2d: Sprite2D = $Sprite2D

#signal mouseclick(click_coords: Vector2)
#signal mouse_up(click_coords: Vector2)

# Tween vars
var hover_tween: Tween = null
var normal_scale = Vector2.ONE
var hover_scale = Vector2(1.2, 1.2)
var tween_duration = 0.15

func _ready() -> void:
	update_sprite()

func set_trait_sprite(val: CompressedTexture2D) -> void:
	trait_sprite = val
	update_sprite()

func update_sprite() -> void:
	if sprite_2d:
		sprite_2d.texture = trait_sprite


#func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	## If clicked within this area
	#if event is InputEventMouseButton:
		#if event.pressed:
			#mouseclick.emit(get_global_mouse_position())
		#else:
			#mouse_up.emit(get_global_mouse_position())

func _on_area_2d_mouse_entered():
	_start_hover_tween(hover_scale)

func _on_area_2d_mouse_exited():
	_start_hover_tween(normal_scale)

func _start_hover_tween(target_scale: Vector2):
	if hover_tween:
		hover_tween.kill()  # Stop previous tween if it's still running
	hover_tween = create_tween()
	hover_tween.tween_property(sprite_2d, "scale", target_scale, tween_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
