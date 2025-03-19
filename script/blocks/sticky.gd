extends Node2D

func _on_body_entered(body: RigidBody2D) -> void:
	if body == self:
		print("1Collided with SELF: ", body.name)
		return
	body.linear_velocity = Vector2(0,0)
