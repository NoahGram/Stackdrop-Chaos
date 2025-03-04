extends Node

const State = preload("res://script/StateMachine/states.gd").BlockState
var current_state = State.SPAWNING

@onready var collision_shape = get_parent().get_node("CollisionShape2D")
@onready var parent_block = get_parent() as RigidBody2D

@export var animation_player: AnimationPlayer

func _ready():
	change_state(State.SPAWNING)

func change_state(new_state):
	current_state = new_state
	match current_state:
		State.SPAWNING:
			print("STATE: SPAWNING")
			parent_block.freeze = true
			change_state(State.ACTIVE)

		State.ACTIVE:
			print("STATE: ACTIVE")
			collision_shape.set_deferred("disabled", true)
		State.FALLING:
			print("STATE: FALLING")
			collision_shape.set_deferred("disabled", false)
			parent_block.freeze = false

		State.LANDED:
			print("STATE: LANDED")
			await get_tree().create_timer(0.5).timeout
			if animation_player:
				animation_player.play("grow")  # Play animation if available

		State.DESTROYED:
			parent_block.queue_free()
			
		_: print("Error: Not a Valid STATE")

func on_drop():
	if current_state == State.ACTIVE:
		change_state(State.FALLING)

func on_landed():
	if current_state == State.FALLING:
		change_state(State.LANDED)
