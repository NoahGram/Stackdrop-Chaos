extends Node2D # Broken doesnt reset hehehe

@onready var timer: Timer = $Timer


func _on_timer_timeout() -> void:
	#Engine.time_scale = 0.05
	pass
	
	
func reset():
	#Engine.time_scale = 0.00
	pass
