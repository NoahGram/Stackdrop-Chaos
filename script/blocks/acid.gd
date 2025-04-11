extends Area2D

@onready var acid_block: RigidBody2D = $".."


func _on_body_entered(body: RigidBody2D) -> void:
	if body == self.get_parent():
		return
	
	# Reduce score when block touches acid
	if body.has_method("rip_score"):  
		body.rip_score()  
	
	body.queue_free()
	


func _process(delta: float) -> void:
	if acid_block.current_state == acid_block.BlockState.FALLING:
		melt()


func melt():
	await get_tree().create_timer(4).timeout
	get_parent().queue_free()
