class_name Character
extends Node2D

@onready var trait_container: TraitContainer = $TraitsContainer/TraitContainer
@onready var trait_container_2: TraitContainer = $TraitsContainer/TraitContainer2
@onready var trait_container_3: TraitContainer = $TraitsContainer/TraitContainer3
#var traits_arr = [trait_container, trait_container_2, trait_container_3]

@export var traits: Array[CompressedTexture2D]: set=set_traits

func _ready() -> void:
	#trait_container.trait_sprite = traits[0]
	#trait_container_2.trait_sprite = traits[1]
	#trait_container_3.trait_sprite = traits[2]
	set_traits(traits)

func set_traits(val: Array[CompressedTexture2D]):
	traits = val
	
	if not is_node_ready():
		#_initial_traits = val
		return
	# we have 3 traits to edit
	assert(len(val) == 3)
	trait_container.trait_sprite = traits[0]
	trait_container_2.trait_sprite = traits[1]
	trait_container_3.trait_sprite = traits[2]
