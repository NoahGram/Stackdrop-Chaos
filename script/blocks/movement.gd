extends RigidBody2D

@export var is_active: bool = false
@onready var spawner: Node2D = get_parent()

const move_speed: int = 4
const rotation_speed: float = 90
var block_has_stopped: bool = false  

signal block_stopped  

enum BlockState { SPAWNING, ACTIVE, FALLING, LANDED, DESTROYED }
var current_state = BlockState.SPAWNING

@export var animation_player: AnimationPlayer

# 🔹 Block Score Values (Modify as needed)
const BLOCK_SCORES = {
	"tetris": 100,
	"weight": 200,
	"ball": 150,
	"unique": 300,
	"acid": 0,
}

@export var block_type: String = "tetris"  # Set in the Editor for each block
@onready var ground_level: float = get_node("/root/GameManager/Main/Platform").position.y

var score: int = 0
@onready var score_label: Label = get_node("/root/GameManager/Main/ScoreLabel")  # Adjust path if needed


func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(1)
	change_state(BlockState.SPAWNING)

func change_state(new_state):
	current_state = new_state
	match current_state:
		BlockState.SPAWNING:
			print("STATE: SPAWNING")
			freeze = true
			change_state(BlockState.ACTIVE)

		BlockState.ACTIVE:
			print("STATE: ACTIVE")

		BlockState.FALLING:
			print("STATE: FALLING")
			freeze = false

		BlockState.LANDED:
			print("STATE: LANDED")
			calculate_score()
			await get_tree().create_timer(0.5).timeout
			if animation_player:
				animation_player.play("grow")

		BlockState.DESTROYED:
			queue_free()

func _physics_process(delta: float) -> void:
	if current_state == BlockState.ACTIVE:
		global_position.x = clamp(global_position.x, 175, 1675)
		
		if Input.is_action_pressed("left"):
			position.x -= move_speed
		if Input.is_action_pressed("right"):
			position.x += move_speed
		if Input.is_action_just_pressed("rotate"):
			rotation += deg_to_rad(rotation_speed)
		if Input.is_action_just_pressed("drop_block"):
			change_state(BlockState.FALLING)

func _on_body_entered(body: PhysicsBody2D) -> void:
	if block_has_stopped:
		return 
		
	block_has_stopped = true
	change_state(BlockState.LANDED)
	emit_signal("block_stopped")


func calculate_score():
	var base_score = BLOCK_SCORES.get(block_type, 100)  
	var height_diff = abs(global_position.y - ground_level)  
	var multiplier = 1.0

	if height_diff > 10:  
		multiplier += height_diff / 100.0  

	var final_score = round(base_score * multiplier)
	ScoreManager.add_score(final_score)

	if score_label:
		score_label.text = "Score: " + str(ScoreManager.total_score)
		
func rip_score():
	var base_score = BLOCK_SCORES.get(block_type, 100)  # Get block score
	var height_diff = abs(global_position.y - ground_level)  
	var multiplier = 1.5

	if height_diff > 10:  
		multiplier += height_diff / 100.0  

	var penalty = round(base_score * multiplier)

	# Subtract from total score (ensure it doesn't go negative)
	ScoreManager.total_score = max(0, ScoreManager.total_score - penalty)

	# Update score display
	if score_label:
		score_label.text = "Score: " + str(ScoreManager.total_score)

	print("Penalty Applied: ", penalty, " | New Total Score: ", ScoreManager.total_score)
