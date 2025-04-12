extends RigidBody2D

@export var is_active: bool = false
@export var block_type: String = "tetris"

@onready var spawner: Node2D = get_parent()
@onready var ground_level: float = get_node("/root/GameManager/Main/Platform").position.y
@onready var score_label: Label = get_node("/root/GameManager/Main/ScoreLabel")

const move_speed: int = 4
const rotation_speed: float = 90

var score: int = 0
var block_has_stopped: bool = false  
var current_state = BlockState.SPAWNING

signal block_stopped  

enum BlockState { SPAWNING, ACTIVE, FALLING, LANDED }

@export var animation_player: AnimationPlayer

const BLOCK_SCORES = {
	"tetris": 100,
	"weight": 200,
	"ball": 150,
	"unique": 300,
	"acid": 0,
}


func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(1)
	change_state(BlockState.SPAWNING)

func change_state(new_state):
	current_state = new_state
	match current_state:
		BlockState.SPAWNING:
			freeze = true
			change_state(BlockState.ACTIVE)

		BlockState.ACTIVE:
			pass

		BlockState.FALLING:
			freeze = false

		BlockState.LANDED:
			calculate_score()
			await get_tree().create_timer(0.5).timeout
			if animation_player:
				animation_player.play("grow")

func _physics_process(delta: float) -> void:
	if current_state == BlockState.ACTIVE:
		global_position.x = clamp(global_position.x, 175, 1675)
		
		if Input.is_action_pressed("left"):
			position.x -= move_speed
		if Input.is_action_pressed("right"):
			position.x += move_speed
		if Input.is_action_just_pressed("rotate"):
			var rotate = create_tween()
			rotate.tween_property(
				self, 
				"rotation", 
				rotation + deg_to_rad(rotation_speed),
				0.5
			)

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
	var base_score = BLOCK_SCORES.get(block_type, 100)
	var height_diff = abs(global_position.y - ground_level)  
	var multiplier = 1.5

	if height_diff > 10:  
		multiplier += height_diff / 100.0  

	var penalty = round(base_score * multiplier)
	ScoreManager.total_score = max(0, ScoreManager.total_score - penalty)

	if score_label:
		score_label.text = "Score: " + str(ScoreManager.total_score)

	#print("Penalty Applied: ", penalty, " | New Total Score: ", ScoreManager.total_score)
