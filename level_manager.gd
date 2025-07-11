extends Node

## Player score
var score := 0

@export var level_scene: PackedScene = preload("res://main_board.tscn")
const SWIPE_TRANSITION = preload("res://swipe_transition.tscn")

#var current_scene = 
const HAND_YELLOW_POINT = preload("res://assets/kenney_shape-characters/PNG/Default/hand_yellow_point.png")
const HAND_YELLOW_ROCK = preload("res://assets/kenney_shape-characters/PNG/Default/hand_yellow_rock.png")

var sprite_paths: PackedStringArray = []
const SPRITE_PATH = "res://assets/traits/"

## Move onto next scene with transition
func next_scene():
	var ts = get_new_traits()
	var transition = SWIPE_TRANSITION.instantiate()
	get_tree().root.add_child(transition)
	transition.start_transition(level_scene, ts)

## Calculate traits for a level
func get_new_traits() -> Dictionary[String, Array]:
	#var pc_traits: Array[CompressedTexture2D] = [HAND_YELLOW_POINT,HAND_YELLOW_POINT,HAND_YELLOW_POINT]
	#var char_traits: Array[CompressedTexture2D] = [HAND_YELLOW_ROCK,HAND_YELLOW_ROCK,HAND_YELLOW_ROCK]
	
	# Shuffle available options
	var shuffled = Array(sprite_paths.duplicate())
	shuffled.shuffle()
	# shared option
	var pc_sprite_paths = [shuffled[0]]
	var npc_sprite_paths = [shuffled[0]]
	shuffled.pop_front()
	# fill out rest
	for i in range(2):
		pc_sprite_paths.append(shuffled[0])
		shuffled.pop_front()
		npc_sprite_paths.append(shuffled[0])
		shuffled.pop_front()
	# shuffle traits
	pc_sprite_paths.shuffle()
	npc_sprite_paths.shuffle()
	
	# turn paths into textures
	var pc_traits: Array[CompressedTexture2D] = []
	for p in pc_sprite_paths:
		pc_traits.append(ResourceLoader.load(SPRITE_PATH + p))
	var npc_traits: Array[CompressedTexture2D] = []
	for p in npc_sprite_paths:
		npc_traits.append(ResourceLoader.load(SPRITE_PATH + p))
	return {"pc": pc_traits, "npc": npc_traits}

func _ready() -> void:
	# get available trait sprites
	sprite_paths = ResourceLoader.list_directory(SPRITE_PATH)
