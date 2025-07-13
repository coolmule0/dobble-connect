class_name Character
extends Node2D

@onready var trait_container: TraitContainer = $TraitsContainer/TraitContainer
@onready var trait_container_2: TraitContainer = $TraitsContainer/TraitContainer2
@onready var trait_container_3: TraitContainer = $TraitsContainer/TraitContainer3
@onready var trait_container_4: TraitContainer = $TraitsContainer/TraitContainer4
@onready var trait_container_5: TraitContainer = $TraitsContainer/TraitContainer5

var traits_arr: Array[TraitContainer]
@onready var traits_container: Node2D = $TraitsContainer

@export var traits: Array[CompressedTexture2D]: set=set_traits

const TRAIT_CONTAINER = preload("res://trait_container.tscn")

func _ready() -> void:
	traits_arr = [trait_container, trait_container_2, trait_container_3, trait_container_4, trait_container_5]
	#trait_container.trait_sprite = traits[0]
	#trait_container_2.trait_sprite = traits[1]
	#trait_container_3.trait_sprite = traits[2]
	set_traits(traits)

func set_traits(val: Array[CompressedTexture2D]):
	traits = val
	
	if not is_node_ready():
		return
	# we have up to 5 traits to edit
	assert(len(val) <= 5)
	assert(len(val) >= 1)

	for c in traits_container.get_children():
		c.visible = false
		c.process_mode = Node.PROCESS_MODE_DISABLED
	
	for i in range(traits.size()):
		traits_arr[i].trait_sprite = traits[i]
		traits_arr[i].visible = true
		traits_arr[i].process_mode = Node.PROCESS_MODE_INHERIT
	
	# Spread the traits in a half-circle around the character
	#for i in range(traits.size()):
		#traits_arr[i].trait_sprite = traits[i]
		#var tc = TRAIT_CONTAINER.instantiate()
		#traits_container.add_child(tc)
		#tc.trait_sprite = t
		# TODO: position
		# assume each trait image is around 40px radius
