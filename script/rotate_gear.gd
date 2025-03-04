extends Node2D

var is_active = false


func _on_gear_body_entered(body: PhysicsBody2D) -> void:
	
	if body is StaticBody2D:
		return
	
	var rand = randf_range(-60.00, 60.00)
	print("Rotating ", body, " ", rand)
	if not is_active:
		spin(rand, body)
		is_active = true
	
	

func spin(spin: float, block: PhysicsBody2D):
	var tween = get_tree().create_tween()
	tween.tween_property(get_node(block.get_path()).get_node("Sprite2D"), "rotation", spin, 2)
	tween.tween_property(get_node(block.get_path()).get_node("CollisionShape2D"), "rotation", spin, 2)
	
