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

# left - level/score. Right - how many traits per char
var score_breaks := {
	0: 2,
	2: 3,
	10: 4,
	20: 5
}

## Move onto next scene with transition
func next_scene():
	# how many traits this level?
	var nprops := get_property_count(score)
	var ts = get_new_traits(nprops)
	var transition = SWIPE_TRANSITION.instantiate()
	get_tree().root.add_child(transition)
	transition.start_transition(level_scene, ts)

## Calculate traits for a level
func get_new_traits(n_traits_per_char: int = 3) -> Dictionary[String, Array]:
	#var pc_traits: Array[CompressedTexture2D] = [HAND_YELLOW_POINT,HAND_YELLOW_POINT,HAND_YELLOW_POINT]
	#var char_traits: Array[CompressedTexture2D] = [HAND_YELLOW_ROCK,HAND_YELLOW_ROCK,HAND_YELLOW_ROCK]
	# At least 1, so they can match
	assert(n_traits_per_char >= 1)
	
	# Shuffle available options
	var shuffled = Array(sprite_paths.duplicate())
	shuffled.shuffle()
	# shared option
	var pc_sprite_paths = [shuffled[0]]
	var npc_sprite_paths = [shuffled[0]]
	shuffled.pop_front()
	# fill out rest
	for i in range(n_traits_per_char-1):
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

## Given the level, return the number of properties, defined by score_breaks
func get_property_count(level: int) -> int:
	var result := 0
	for score_level in score_breaks.keys():
		if level >= score_level:
			result = score_breaks[score_level]
	return result
