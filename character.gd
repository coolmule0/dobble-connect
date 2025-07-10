class_name Character
extends Node2D

@onready var trait_container: TraitContainer = $TraitsContainer/TraitContainer
@onready var trait_container_2: TraitContainer = $TraitsContainer/TraitContainer2
@onready var trait_container_3: TraitContainer = $TraitsContainer/TraitContainer3
#var traits_arr = [trait_container, trait_container_2, trait_container_3]

@export var traits: Array[CompressedTexture2D]

signal mouseclick(click_coords: Vector2)

func _ready() -> void:
	trait_container.trait_sprite = traits[0]
	trait_container_2.trait_sprite = traits[1]
	trait_container_3.trait_sprite = traits[2]
	
	trait_container.connect("mouseclick", _on_child_clicked)
	trait_container_2.connect("mouseclick", _on_child_clicked)
	trait_container_3.connect("mouseclick", _on_child_clicked)

func _on_child_clicked(global_pos: Vector2):
	emit_signal("mouseclick", global_pos)
