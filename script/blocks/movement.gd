extends RigidBody2D

@export var is_active: bool = false
@onready var spawner: Node2D = get_parent()
@onready var state_machine = $BlockStateMachine

const move_speed: int = 64
const rotation_speed: float = 90
var block_has_stopped: bool = false  

signal block_stopped  

func _ready():
	set_contact_monitor(true)  # Enables collision detection for Rigidbody2D
	set_max_contacts_reported(1)


func _process(delta):
	if not state_machine:
		print("Error: No State Machine")
		return

	if state_machine.current_state == state_machine.State.ACTIVE:
		if Input.is_action_just_pressed("left"):
			position.x -= move_speed
		if Input.is_action_just_pressed("right"):
			position.x += move_speed
		if Input.is_action_just_pressed("rotate"):
			rotation += deg_to_rad(rotation_speed)
		if Input.is_action_just_pressed("drop_block"):
			state_machine.on_drop()


func _on_body_entered(body: PhysicsBody2D) -> void:
	if not state_machine:
		print("Error: No StateMachine Found: ", state_machine)
		return
		
	if block_has_stopped:
		return # prevents Spam Spawn
		
	block_has_stopped = true
	state_machine.on_landed()
	emit_signal("block_stopped")  # Notify the spawner
