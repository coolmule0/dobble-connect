@tool
class_name TraitContainer
extends Marker2D

@export var trait_sprite: CompressedTexture2D : set = set_trait_sprite

@onready var sprite_2d: Sprite2D = $Sprite2D

signal mouseclick(click_coords: Vector2)

func _ready() -> void:
	update_sprite()

func set_trait_sprite(val: CompressedTexture2D) -> void:
	trait_sprite = val
	update_sprite()

func update_sprite() -> void:
	if sprite_2d:
		sprite_2d.texture = trait_sprite


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		#print("Area2D clicked!")
		mouseclick.emit(get_global_mouse_position())
