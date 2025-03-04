extends Area2D
@onready var acid_block: RigidBody2D = $".."

@onready var block_state_machine: Node = $"../BlockStateMachine"

func _on_body_entered(body: RigidBody2D) -> void:
	if body == self.get_parent():
		return
	
	body.queue_free()

func _process(delta: float) -> void:
	if block_state_machine.current_state == block_state_machine.State.FALLING:
		melt()

func _on_acid_block_ready():
	pass
	#await get_tree().create_timer(4).timeout
	#get_parent().queue_free()


func melt():
	await get_tree().create_timer(4).timeout
	get_parent().queue_free()
