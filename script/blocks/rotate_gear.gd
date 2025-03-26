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
	
	if block.find_child("Sprite2D"):
		tween.tween_property(block.find_child("Sprite2D"), "rotation", spin, 2)
	elif block.find_child("AnimatedSprite2D"):
		tween.tween_property(block.find_child("AnimatedSprite2D"), "rotation", spin, 2)
	else:
		print("Error: No CollisionShape Found")
	
	
	if block.find_child("CollisionPolygon2D"):
		tween.parallel().tween_property(block.find_child("CollisionPolygon2D"), "rotation", spin, 2)
	elif block.find_child("CollisionShape2D"):
		tween.parallel().tween_property(block.find_child("CollisionShape2D"), "rotation", spin, 2)
	else:
		print("Error: No CollisionShape Found")
