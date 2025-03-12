extends Node2D

var block_scenes: Dictionary = {}
@export var tetris_scenes: Array[PackedScene] = []
@export var weight_scenes: Array[PackedScene] = []
@export var ball_scenes: Array[PackedScene] = []
@export var unique_scenes: Array[PackedScene] = []

const weights = preload("res://script/weights.gd").WEIGHTS

@export var spawn_position: Vector2
var spawner_locked = false  # Prevents multiple spawns

@onready var cam: Camera2D
@onready var landing_detector: Area2D

var current_block
var bag = []
@export var bag_size: int = 7


func _ready():
	cam = get_node("Camera")
	landing_detector = get_node("LandingDetector")
	
	# Fill Dictionary & Set Rarity Keys
	block_scenes = {
		"common": tetris_scenes,
		"rare": ball_scenes,
		"unique": weight_scenes,
		"legendary": unique_scenes,
		}

	fill_bag()
	spawn_block()

func fill_bag():
	bag.clear()
	while bag.size() < bag_size:
		var rand = randf() * 100
		var selected_category = ""
		
		# Select Category
		if rand <= weights["common"]:
			selected_category = "common"
		elif rand <= weights["common"] + weights["rare"]:
			selected_category = "rare"
		elif rand <= weights["common"] + weights["rare"] + weights["unique"]:
			selected_category = "unique"
		else:
			selected_category = "legendary"

		var scene_list = block_scenes[selected_category]
		if scene_list.size() > 0:
			var random_scene = scene_list.pick_random()  # Pick a random scene from the selected category
			bag.append(random_scene)
			
	bag.shuffle()

func spawn_block():
	if spawner_locked:
		return 

	if bag.is_empty():
		fill_bag()

	var next_block = bag.pop_front()
	if next_block == null:
		print("Error: next_block is null")
		return
	
	current_block = next_block.instantiate()

	if current_block is RigidBody2D:
		current_block.position = spawn_position
		add_child(current_block) 
		
		print("Spawned new block!")
		spawner_locked = true  

		current_block.connect("block_stopped", Callable(self, "_on_block_stopped"))


func _on_block_stopped():
	print("Block Dropped - Spawning next block")
	await get_tree().create_timer(1).timeout # Delay Spawning
	spawner_locked = false
	spawn_block()
