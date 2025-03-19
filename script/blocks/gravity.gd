extends Area2D

@onready var gravity_orb: Area2D = get_parent().get_node("Gravity")

@onready var rihgi: RigidBody2D = get_parent()


func _on_body_entered(body: RigidBody2D) -> void:
	if body == self:
		return
		
	gravity_orb.gravity_point_center
